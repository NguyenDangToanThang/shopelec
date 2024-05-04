
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/res/components/round_button.dart';
import 'package:shopelec/view_model/auth_view_model.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Don't worry sometimes people can forget too, enter your email "
                  "and we will send you a password reset link.",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: height * 0.03),

            Form(
              key: _formKey,
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email)
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Please enter email";
                  } else if(!EmailValidator.validate(value)) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: height * 0.02),
            RoundButton(
                title: 'Submit',
                onPress: () {
                  if(_formKey.currentState!.validate()) {
                    Map data = {
                      'email' : _emailController.text.toString()
                    };
                    authViewModel.forgotPasswordFirebase(data, context);
                  }
                }
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if(_formKey.currentState!.validate()) {
                      Map data = {
                        'email' : _emailController.text.toString()
                      };
                      authViewModel.forgotPasswordFirebase(data, context);
                    }
                  },
                  child: const Text(
                    'Resend Email',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
