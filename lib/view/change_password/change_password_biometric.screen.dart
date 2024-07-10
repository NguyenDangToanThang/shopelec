import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/view_model/auth_view_model.dart';

class ChangePasswordBiometricScreen extends StatefulWidget {
  const ChangePasswordBiometricScreen({super.key});

  @override
  State<ChangePasswordBiometricScreen> createState() =>
      _ChangePasswordBiometricScreenState();
}

class _ChangePasswordBiometricScreenState
    extends State<ChangePasswordBiometricScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Mật khẩu mới',
                  labelText: 'Mật khẩu mới',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.new_releases),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu mới';
                  }
                  if (value.length < 6) {
                    return 'Mật khẩu phải có ít nhất 6 ký tự';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  hintText: 'Xác nhận mật khẩu mới',
                  labelText: 'Xác nhận mật khẩu mới',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.confirmation_num),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu mới';
                  }
                  if (value.length < 6) {
                    return 'Mật khẩu phải có ít nhất 6 ký tự';
                  }
                  if (value != _passwordController.text) {
                    return 'Mật khẩu không trùng khớp';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (_errorMessage != null) ...[
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 20),
              ],
              if (_isLoading)
                const CircularProgressIndicator()
              else
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<AuthViewModel>(context, listen: false)
                          .changePassword(_passwordController.text, context);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        "Đổi mật khẩu",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
