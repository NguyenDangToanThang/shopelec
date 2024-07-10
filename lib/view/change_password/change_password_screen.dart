import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/view_model/auth_view_model.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  String? _oldPassword;

  @override
  void initState() {
    super.initState();
    _loadOldPassword();
  }

  Future<void> _loadOldPassword() async {
    _oldPassword = await context.read<AuthViewModel>().getOldPassword();
  }

  @override
  void dispose() {
    super.dispose();

    _oldPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _oldPassword = null;
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
              TextFormField(
                controller: _oldPasswordController,
                decoration: const InputDecoration(
                  hintText: 'Mật khẩu cũ',
                  labelText: 'Mật khẩu cũ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu cũ';
                  }
                  if (value != _oldPassword) {
                    return 'Mật khẩu cũ không đúng';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
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
