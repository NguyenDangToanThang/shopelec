
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

  String getUserCurrent() {
    var user = FirebaseAuth.instance.currentUser?.email;
    if(user!=null) {
      return user.toString();
    }
    return "";
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

      setLoading(false);
      Utils.flushBarSuccessMessage("Login Successfully", context);
      Navigator.pushReplacementNamed(context, RoutesName.home);
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
        // _myRepo.registerApi(data);
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
        // Utils.flushBarErrorMessage(e.toString(), context);
        if(e.code == "email-already-in-use") {
          Utils.flushBarSuccessMessage("Email already exists", context);
        }
      } on Exception catch(e) {
        setSignUpLoading(false);
        Utils.flushBarErrorMessage(e.toString(), context);
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