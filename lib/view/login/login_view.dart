import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopelec/res/components/round_button.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/view_model/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final _formKey = GlobalKey<FormState>();

  bool _rememberMe = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                  "assets/images/login_image.png",
                  fit: BoxFit.cover),
              SizedBox(height: height * 0.02,),
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: height * 0.01,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        focusNode: emailFocusNode,
                        decoration: const InputDecoration(
                            hintText: 'E-mail',
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email)
                        ),
                        onFieldSubmitted: (value) {
                          Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                        },
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return "Please enter email";
                          } else if(!EmailValidator.validate(value)) {
                            return "Invalid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.01,),
                      ValueListenableBuilder(
                          valueListenable: _obsecurePassword,
                          builder: (context , value , child) {
                            return TextFormField(
                              controller: _passwordController,
                              textInputAction: TextInputAction.done,
                              focusNode: passwordFocusNode,
                              obscureText: _obsecurePassword.value,
                              obscuringCharacter: "*",
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  labelText: 'Password',
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      _obsecurePassword.value = !_obsecurePassword.value;
                                    },
                                    child: _obsecurePassword.value ?
                                    const Icon(Icons.visibility_off_outlined) :
                                    const Icon(Icons.visibility_outlined),
                                  )
                              ),
                              validator: (value) {
                                if(value == null || value.isEmpty) {
                                  return "Please enter password";
                                } else if(value.length < 6) {
                                  return "Please enter 6 digit password";
                                }
                                return null;
                              },
                            );
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                          ),
                          const Text('Remember Me'),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesName.forgotPassword);
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              RoundButton(
                  title: "Login",
                  loading: authViewModel.loading,
                  onPress: () {
                    if(_formKey.currentState!.validate()) {
                      Map data = {
                        'email' : _emailController.text.toString(),
                        'password' : _passwordController.text.toString()
                      };
                      // authViewModel.loginApi(data , context);
                      Navigator.pushReplacementNamed(context, RoutesName.home);
                    }
              }),
              SizedBox(height: height * 0.02,),
              RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.black
                          )
                      ),
                      TextSpan(
                        text: "Sign up",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, RoutesName.signup);
                        },
                        style: const TextStyle(
                          color: Colors.blue, // Màu cho liên kết
                        ),
                      ),
                    ]
                  )
              ),
            ],
          ),
        ),
      )
    );
  }
}

