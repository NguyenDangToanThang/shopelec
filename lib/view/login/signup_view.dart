
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
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();

  bool _agreePolicy = false;


  @override
  void dispose() {
    // TODO: implement dispose
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
                Image.asset(
                    "assets/images/signup_image.png",
                    fit: BoxFit.cover),
                SizedBox(height: height * 0.01,),
                const Text(
                  "Create an account",
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
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            focusNode: nameFocusNode,
                            decoration: const InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person_2)
                            ),
                            onFieldSubmitted: (value) {
                              Utils.fieldFocusChange(context, nameFocusNode, phoneNumberFocusNode);
                            },
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Please enter name";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: height * 0.01,),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            focusNode: emailFocusNode,
                            decoration: const InputDecoration(
                                labelText: 'E-mail',
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
                                      labelText: 'Password',
                                      prefixIcon: const Icon(Icons.lock),
                                      border: const OutlineInputBorder(),
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          _obsecurePassword.value = !_obsecurePassword.value;
                                        },
                                        child: _obsecurePassword.value ?
                                        const Icon(Icons.visibility_off) :
                                        const Icon(Icons.visibility),
                                      )
                                  ),
                                  onFieldSubmitted: (value) {
                                    Utils.fieldFocusChange(context, passwordFocusNode, nameFocusNode);
                                  },
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
                          SizedBox(height: height * 0.01,),
                          TextFormField(
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.number,
                            focusNode: phoneNumberFocusNode,
                            decoration: const InputDecoration(
                                labelText: 'Phone number',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.phone)
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Please enter number";
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
                                  text: TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: "I agree to the ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13
                                            )
                                        ),
                                        TextSpan(
                                          text: "Terms ",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                          style: const TextStyle(
                                            color: Colors.blue,
                                              fontSize: 13
                                          ),
                                        ),
                                        const TextSpan(
                                            text: "and ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13
                                            )
                                        ),
                                        TextSpan(
                                          text: "Privacy Policy",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 13
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                ),
                RoundButton(
                    title: "Sign Up",
                    loading: authViewModel.signUploading,
                    onPress: () {
                      if(_formKey.currentState!.validate()) {
                        if(_agreePolicy) {
                          String email = _emailController.text.toString();
                          String password = _passwordController.text.toString();
                          String name = _nameController.text.toString();
                          String phoneNumber = _phoneNumberController.text.toString();
                          Map data = {
                            'email' : email,
                            'password' : password,
                            'name' : name,
                            'phone_number' : phoneNumber
                          };
                          authViewModel.signUp(data, context);
                          // authViewModel.signUpFirebase(email, password, context);
                        } else {
                          Utils.flushBarErrorMessage("You cannot register if you do not agree to our terms", context);
                        }
                      }
                    }),
                SizedBox(height: height * 0.02,),
                RichText(
                    text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              color: Colors.black
                            )
                          ),
                          TextSpan(
                            text: "Login",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(context, RoutesName.login);
                              },
                            style: const TextStyle(
                              color: Colors.blue, // Màu cho liên kết
                            ),
                          ),
                        ]
                    )
                ),
                SizedBox(height: height * 0.08,),
              ],
            ),
          ),
        )
    );
  }
}
