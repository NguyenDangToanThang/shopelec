import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:shopelec/repository/auth_repository.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  final logger = Logger();

  bool _loading = false;
  bool _signUpLoading = false;

  bool get loading => _loading;
  bool get signUploading => _signUpLoading;

  var _user = FirebaseAuth.instance.currentUser;

  get user => _user;

  setUser(FirebaseAuth firebaseAuth) {
    _user = firebaseAuth.currentUser;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> updateUser(dynamic data) async {
    if (data['name'] != null) {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(data['name']);
    }
    await _myRepo
        .updateUserApi(data)
        .onError((error, stackTrace) => logger.e(error));
  }

  Future<dynamic> getInfomation(String? id) {
    final json = _myRepo
        .getMyInfoApi(id!)
        .onError((error, stackTrace) => logger.e(error));
    logger.i(json);
    return json;
  }

  Future<void> forgotPasswordFirebase(
      dynamic data, BuildContext context) async {
    try {
      final String email = data['email'];
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
    }
  }

  Future<void> loginFirebase(dynamic data, BuildContext context) async {
    setLoading(true);
    try {
      final String email = data['email'];
      final String password = data['password'];

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setUser(FirebaseAuth.instance);
      });

      // logger.i(FirebaseAuth.instance.currentUser?.displayName);
      Navigator.pushReplacementNamed(context, RoutesName.home);
      setLoading(false);
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      // Utils.flushBarErrorMessage(error.message.toString(), context);
      if (e.code == "invalid-credential") {
        Utils.flushBarErrorMessage(
            "Tài khoản hoặc mật khẩu không chính xác", context);
      } else {
        Utils.flushBarErrorMessage(e.code.toString(), context);
      }
    }
  }

  Future<void> signUp(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    try {
      final String email = data['email'];
      final String password = data['password'];
      final String name = data['name'];

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        final user = value.user;
        user!.updateDisplayName(name);
        data['id'] = user.uid;
        _myRepo
            .registerApi(data)
            .onError((error, stackTrace) => logger.e(error));
      });

      setSignUpLoading(false);
      Utils.flushBarSuccessMessage("Đăng ký thành công", context);
    } on FirebaseAuthException catch (e) {
      setSignUpLoading(false);
      if (e.code == "email-already-in-use") {
        Utils.flushBarErrorMessage("Tài khoản đã tồn tại", context);
      }
    } on Exception {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage("Tài khoản đã tồn tại", context);
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance
        .signOut()
        .onError((error, stackTrace) => logger.e(error));
    Navigator.pushReplacementNamed(context, RoutesName.login);
  }
}
