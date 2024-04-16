
import 'package:flutter/material.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/home_screen.dart';
import 'package:shopelec/view/login/forgot_password_view.dart';
import 'package:shopelec/view/login/login_view.dart';
import 'package:shopelec/view/login/signup_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch(settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (BuildContext context) => const SignUpView());
      case RoutesName.forgotPassword:
        return MaterialPageRoute(builder: (BuildContext context) => const ForgotPasswordView());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Error"),
            ),
            body: const Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}