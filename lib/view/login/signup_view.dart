import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/res/components/round_button.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/utils/utils.dart';
import 'package:shopelec/view_model/auth_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();

  bool _agreePolicy = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    nameFocusNode.dispose();
    phoneNumberFocusNode.dispose();

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
            Image.asset("assets/images/signup_image.png", fit: BoxFit.cover),
            SizedBox(
              height: height * 0.01,
            ),
            const Text(
              "Tạo tài khoản",
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
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      focusNode: nameFocusNode,
                      decoration: const InputDecoration(
                          labelText: 'Tên người dùng',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person_2)),
                      onFieldSubmitted: (value) {
                        Utils.fieldFocusChange(
                            context, nameFocusNode, phoneNumberFocusNode);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Hãy nhập tên người dùng";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFocusNode,
                      decoration: const InputDecoration(
                          labelText: 'E-mail',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email)),
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
                      height: height * 0.01,
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
                                labelText: 'Mật khẩu',
                                prefixIcon: const Icon(Icons.lock),
                                border: const OutlineInputBorder(),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    _obsecurePassword.value =
                                        !_obsecurePassword.value;
                                  },
                                  child: _obsecurePassword.value
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                )),
                            onFieldSubmitted: (value) {
                              Utils.fieldFocusChange(
                                  context, passwordFocusNode, nameFocusNode);
                            },
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
                    SizedBox(
                      height: height * 0.01,
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.number,
                      focusNode: phoneNumberFocusNode,
                      decoration: const InputDecoration(
                          labelText: 'Số điện thoại',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Hãy nhập số điện thoại";
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _agreePolicy,
                          onChanged: (value) {
                            setState(() {
                              _agreePolicy = value!;
                            });
                          },
                        ),
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Tôi đồng ý với ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13)),
                          TextSpan(
                            text: "Điều khoản ",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, RoutesName.policy);
                              },
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 13),
                          ),
                          const TextSpan(
                              text: "và ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13)),
                          TextSpan(
                            text: "Chính sách",
                            recognizer: TapGestureRecognizer()..onTap = () {
                                Navigator.pushNamed(context, RoutesName.policy);
                            },
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 13),
                          ),
                        ])),
                      ],
                    )
                  ],
                ),
              ),
            ),
            RoundButton(
                title: "Đăng ký",
                loading: authViewModel.signUploading,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    if (_agreePolicy) {
                      String email = _emailController.text.toString();
                      String password = _passwordController.text.toString();
                      String name = _nameController.text.toString();
                      String phoneNumber =
                          _phoneNumberController.text.toString();
                      Map data = {
                        'email': email,
                        'password': password,
                        'name': name,
                        'phoneNumber': phoneNumber
                      };
                      authViewModel.signUp(data, context);
                      // authViewModel.signUpFirebase(email, password, context);
                    } else {
                      Utils.flushBarErrorMessage(
                          "Bạn không thể đăng ký nếu bạn không đồng ý với các điều khoản của chúng tôi",
                          context);
                    }
                  }
                }),
            SizedBox(
              height: height * 0.02,
            ),
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: "Đã có tài khoản? ",
                  style: TextStyle(color: Colors.black)),
              TextSpan(
                text: "Đăng nhập",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacementNamed(context, RoutesName.login);
                  },
                style: const TextStyle(
                  color: Colors.blue, // Màu cho liên kết
                ),
              ),
            ])),
            SizedBox(
              height: height * 0.08,
            ),
          ],
        ),
      ),
    ));
  }
}
