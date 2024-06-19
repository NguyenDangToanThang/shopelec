import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
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
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final logger = Logger();

  final _formKey = GlobalKey<FormState>();

  bool _rememberMe = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool checkBiometric = false;

  @override
  void initState() {
    super.initState();

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    checkBiometric = authViewModel.isBiometricEnabled;
    logger.i(checkBiometric);
    if (checkBiometric == true) {
      _emailController.text = authViewModel.username.toString();
    }
  }

  @override
  void dispose() {
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

    // setState(() {
    //   checkBiometric = authViewModel.isBiometricEnabled;
    //   // logger.i(checkBiometric);
    //   if (checkBiometric) {
    //     _emailController.text = authViewModel.username.toString();
    //   }
    // });

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/login_image.png", fit: BoxFit.cover),
            SizedBox(
              height: height * 0.02,
            ),
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFocusNode,
                      readOnly: checkBiometric,
                      enabled: !checkBiometric,
                      decoration: InputDecoration(
                          hintText: 'E-mail',
                          labelText: checkBiometric ? '' : 'E-mail',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.email)),
                      onFieldSubmitted: (value) {
                        Utils.fieldFocusChange(
                            context, emailFocusNode, passwordFocusNode);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Hãy nhập E-mail";
                        } else if (!EmailValidator.validate(value)) {
                          return "E-mail không hợp lệ";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    ValueListenableBuilder(
                        valueListenable: _obsecurePassword,
                        builder: (context, value, child) {
                          return TextFormField(
                            controller: _passwordController,
                            textInputAction: TextInputAction.done,
                            focusNode: passwordFocusNode,
                            obscureText: _obsecurePassword.value,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                                hintText: 'Mật khẩu',
                                labelText: 'Mật khẩu',
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    _obsecurePassword.value =
                                        !_obsecurePassword.value;
                                  },
                                  child: _obsecurePassword.value
                                      ? const Icon(
                                          Icons.visibility_off_outlined)
                                      : const Icon(Icons.visibility_outlined),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Hãy nhập mật khẩu";
                              } else if (value.length < 6) {
                                return "Mật khẩu phải có ít nhất 6 ký tự";
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
                        const Text('Lưu đăng nhập'),
                        const Spacer(),
                        checkBiometric
                            ? InkWell(
                                onTap: () async {
                                  await authViewModel.toggleBiometric(false);
                                  setState(() {
                                    checkBiometric = false;
                                  });

                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, RoutesName.login);
                                },
                                child: const Text(
                                  'Đổi tài khoản',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.forgotPassword);
                                },
                                child: const Text(
                                  'Quên mật khẩu?',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                              )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            checkBiometric
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          authViewModel.signInWithBiometrics(context);
                        },
                        child: Image.asset("assets/images/touch_ID.png",
                            height: 50, width: 50, fit: BoxFit.cover),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Map data = {
                              'email': _emailController.text.toString(),
                              'password': _passwordController.text.toString()
                            };
                            authViewModel.loginFirebase(data, context);
                          }
                        },
                        child: Container(
                          height: 60,
                          width: 240,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                              child: authViewModel.loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text(
                                      "Đăng nhập",
                                      style: TextStyle(color: Colors.white),
                                    )),
                        ),
                      ),
                    ],
                  )
                : RoundButton(
                    title: "Đăng nhập",
                    loading: authViewModel.loading,
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        Map data = {
                          'email': _emailController.text.toString(),
                          'password': _passwordController.text.toString()
                        };
                        authViewModel.loginFirebase(data, context);
                      }
                    }),
            SizedBox(
              height: height * 0.02,
            ),
            checkBiometric
                ? const SizedBox(height: 0)
                : RichText(
                    text: TextSpan(children: [
                    const TextSpan(
                        text: "Bạn chưa có tài khoản? ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text: "Đăng ký",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(
                              context, RoutesName.signup);
                        },
                      style: const TextStyle(
                        color: Colors.blue, // Màu cho liên kết
                      ),
                    ),
                  ])),
            const SizedBox(height: 20)
          ],
        ),
      ),
    ));
  }
}
