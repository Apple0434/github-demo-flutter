import 'package:booksapp/ui/sign%20up/sign_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:booksapp/ui/sign up/sign_account.dart'; // ← nhớ import

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignUpHome();
  }
}

class SignUpHome extends StatefulWidget {
  const SignUpHome({super.key});

  @override
  State<SignUpHome> createState() => _SignUpHomeState();
}

class _SignUpHomeState extends State<SignUpHome> {
  final _userText = TextEditingController();
  final _passText = TextEditingController();
  final _passTextconfirm = TextEditingController();
  final _emailText = TextEditingController();

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Thông báo'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _userText,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tên đăng nhập',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passText,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mật khẩu',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passTextconfirm,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Xác nhận mật khẩu',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailText,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final username = _userText.text.trim();
                final password = _passText.text;
                final confirmPass = _passTextconfirm.text;
                final email = _emailText.text.trim();

                if (username.isEmpty || password.isEmpty || confirmPass.isEmpty || email.isEmpty) {
                  _showDialog('Vui lòng điền đầy đủ thông tin');
                  return;
                }

                if (password != confirmPass) {
                  _showDialog('Mật khẩu xác nhận không khớp');
                  return;
                }

                try {
                  await AccountDatabase.instance.saveAccount({
                    'username': username,
                    'password': password,
                    'email': email,
                  });
                  _showDialog('Đăng ký thành công');
                } catch (e) {
                  _showDialog(e.toString().replaceAll('Exception: ', ''));
                }
              },
              child: const Text('Đăng ký'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, child: const Text('Quay lại'),
            )
          ],
        ),
      ),
    );
  }
}
