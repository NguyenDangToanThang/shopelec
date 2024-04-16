
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

  Future<void> loginFirebase(dynamic data , BuildContext context) async {
    setLoading(true);
    try {
      final String email = data['email'];
      final String password = data['password'];

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      setLoading(false);
      Utils.flushBarSuccessMessage("Login Successfully", context);
      Navigator.pushNamed(context, RoutesName.home);
    } catch (error) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    }
  }

  Future<void> signUp(dynamic data , BuildContext context) async {
    setSignUpLoading(true);
    try {
      _myRepo.registerApi(data);
      try {
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
        if(e.code == 'weak-password') {
          Utils.flushBarErrorMessage("Password provided is too weak", context);
        } else if(e.code == 'email-already-in-use') {
          Utils.flushBarErrorMessage("Account already exists", context);
        }
      }
    } catch (error) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    }

    // _myRepo.registerApi(data).then((value) {
    //   setSignUpLoading(false);
    //   Utils.flushBarSuccessMessage("Register Successfully", context);
    //   // Navigator.pushNamed(context, RoutesName.login);
    // }).onError((error, stackTrace) {
    //   setSignUpLoading(false);
    //   Utils.flushBarErrorMessage(error.toString(), context);
    // });
  }
}