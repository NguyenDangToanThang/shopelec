
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:shopelec/repository/auth_repository.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/utils/utils.dart';

class AuthViewModel with ChangeNotifier {

  final _myRepo = AuthRepository();

  bool _loading = false;
  bool _signUpLoading = false;

  bool get loading => _loading;
  bool get signUploading => _signUpLoading;

  Map _infoUserCurrent = {};
  Map get infoUserCurrent => _infoUserCurrent;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  setInfoUserCurrent(Map data) {
    _infoUserCurrent = data;
    notifyListeners();
  }

  Future<void> updateUser(dynamic data, BuildContext context) async {
    await _myRepo.updateUserApi(data).whenComplete(() => setInfoUserCurrent(data))
        .onError((error, stackTrace) => print(error.toString()));
    ;
  }

  Future<dynamic> getInfoUserCurrent(String email) async {
    dynamic response = await _myRepo.getMyInfoApi(email);
    print(response);
    setInfoUserCurrent(response);
    return response;
  }

  Future<void> forgotPasswordFirebase(dynamic data , BuildContext context) async {
    try {
      final String email = data['email'];

      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email
      );
    } on FirebaseAuthException catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
    }
  }

  Future<void> loginFirebase(dynamic data , BuildContext context) async {
    setLoading(true);
    try {
      final String email = data['email'];
      final String password = data['password'];

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      dynamic response = await _myRepo.getMyInfoApi(email);
      print(response);
      setInfoUserCurrent(response);
      Navigator.pushReplacementNamed(context, RoutesName.home);
      setLoading(false);
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      // Utils.flushBarErrorMessage(error.message.toString(), context);
      if(e.code == "invalid-credential") {
        Utils.flushBarErrorMessage("Invalid email or password", context);
      }
      else {
        Utils.flushBarErrorMessage(e.code.toString(), context);
      }
    }
  }

  Future<void> signUp(dynamic data , BuildContext context) async {
    setSignUpLoading(true);
      try {
        _myRepo.registerApi(data);
        final String email = data['email'];
        final String password = data['password'];

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
        setSignUpLoading(false);
        Utils.flushBarSuccessMessage("Register Successfully", context);
      } on FirebaseAuthException catch(e) {
        setSignUpLoading(false);
        if(e.code == "email-already-in-use") {
          Utils.flushBarErrorMessage("Email already exists", context);
        }
      } on Exception catch(e) {
        setSignUpLoading(false);
        Utils.flushBarErrorMessage(e.toString(), context);
      }
  }
  
  Future<void> logout(BuildContext context) async {
    setInfoUserCurrent({});
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, RoutesName.login);
  }
}