
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shopelec/res/components/round_button.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {

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

            TextFormField(
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
            SizedBox(height: height * 0.02),
            RoundButton(
                title: 'Submit',
                onPress: () {

                }
            ),
            SizedBox(height: height * 0.02),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Resend Email',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14
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
