import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopelec/repository/auth_repository.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  final logger = Logger();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isBiometricEnabled = false;
  String? username = "";

  AuthViewModel() {
    _loadBiometricSetting();
  }

  bool _loading = false;
  bool _signUpLoading = false;

  bool get isBiometricEnabled => _isBiometricEnabled;
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

  Future<void> _loadBiometricSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isBiometricEnabled = prefs.getBool('biometric_auth') ?? false;
    username = await _secureStorage.read(key: 'username');
    notifyListeners();
  }

  Future<void> toggleBiometric(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometric_auth', value);

    _isBiometricEnabled = value;
    notifyListeners();
  }

  Future<void> storeUserCredentials(String username, String password) async {
    await _secureStorage.write(key: 'username', value: username);
    await _secureStorage.write(key: 'password', value: password);
  }

  Future<void> clearUserCredentials() async {
    await _secureStorage.delete(key: 'username');
    await _secureStorage.delete(key: 'password');
  }

  Future<void> signInWithBiometrics(BuildContext context) async {
    setLoading(true);
    bool authenticated = await _authenticate();
    if (authenticated) {
      String? username = await _secureStorage.read(key: 'username');
      String? password = await _secureStorage.read(key: 'password');
      if (username != null && password != null) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: username,
              password: password,
            )
            .whenComplete(() => setLoading(false));
        Navigator.pushReplacementNamed(context, RoutesName.home);
      }
    }
  }

  Future<bool> _authenticate() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Xác thực bằng vân tay',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      // print(e);
      return false;
    }
  }

  Future<bool> authenticate() async {
    try {
      return await _localAuth
          .authenticate(
        localizedReason: 'Ủy quyền xác thực vân tay',
        options: const AuthenticationOptions(biometricOnly: true),
      )
          .then((value) {
        if (value) {
          username = FirebaseAuth.instance.currentUser?.email!;
        }
        return value;
      });
    } catch (e) {
      // print(e);
      return false;
    }
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
    return json;
  }

  Future<void> forgotPasswordFirebase(
      dynamic data, BuildContext context) async {
    try {
      final String email = data['email'];
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Utils.flushBarSuccessMessage(
          "Gửi email thành công , kiểm tra email", context);
    } on FirebaseAuthException catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
    }
  }

  Future<void> changePassword(String newPassword, BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? oldPassword = await getOldPassword();
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword ?? "",
      );
      await user.reauthenticateWithCredential(credential);
      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
      await _secureStorage.write(key: 'password', value: newPassword);
      notifyListeners();
      Utils.flushBarSuccessMessage("Đổi mật khẩu thành công", context);
    } on FirebaseAuthException catch (e) {
      Utils.flushBarErrorMessage("Lỗi: $e", context);
      // logger.e(e);
    }
  }

  Future<void> loginFirebase(dynamic data, BuildContext context) async {
    setLoading(true);
    try {
      final String email = data['email'];
      final String password = data['password'];

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      setUser(FirebaseAuth.instance);
      await storeUserCredentials(email, password);
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

  Future<String?> getOldPassword() async {
    return await _secureStorage.read(key: 'password');
  }

  Future<String?> getUsername() async {
    return await _secureStorage.read(key: 'username');
  }
}
