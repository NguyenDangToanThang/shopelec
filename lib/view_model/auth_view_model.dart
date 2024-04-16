
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopelec/repository/auth_repository.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/utils/utils.dart';

class AuthViewModel with ChangeNotifier {

  final _myRepo = AuthRepository();

  bool _loading = false;
  bool _signUpLoading = false;

  bool get loading => _loading;
  bool get signUploading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data , BuildContext context) async {

    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      Utils.flushBarSuccessMessage("Login Successfully", context);
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });

  }

  Future<void> signUpApi(dynamic data , BuildContext context) async {

    setSignUpLoading(true);
    _myRepo.registerApi(data).then((value) {
      setSignUpLoading(false);
      Utils.flushBarSuccessMessage("Register Successfully", context);
      // Navigator.pushNamed(context, RoutesName.login);
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> signUpFirebase(String email , String password , BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      Utils.flushBarSuccessMessage("Register Successfully", context);
    } on FirebaseAuthException catch(e) {
      if(e.code == 'weak-password') {
        Utils.flushBarErrorMessage("Password provided is too weak", context);
      } else if(e.code == 'email-already-in-use') {
        Utils.flushBarErrorMessage("Account already exists", context);

      }
    }
  }
}