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
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  void dispose() {
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
          'Quên mật khẩu',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Đừng lo lắng đôi khi mọi người có thể quên, hãy nhập email của bạn "
              "và chúng tôi sẽ gửi cho bạn liên kết đặt lại mật khẩu.",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: height * 0.03),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: 'E-mail',
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Hãy nhập E-mail";
                  } else if (!EmailValidator.validate(value)) {
                    return "E-mail không hợp lệ";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundButton(
                    loading: _loading,
                    title: 'Gửi',
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _loading = true;
                        });
                        Map data = {'email': _emailController.text.toString()};
                        await authViewModel.forgotPasswordFirebase(
                            data, context);
                        setState(() {
                          _loading = false;
                        });
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
