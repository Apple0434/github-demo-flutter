import 'package:flutter/material.dart';
import 'package:booksapp/ui/sign up/sign_account.dart'; // 🔁 Import SQLite

import '../sign up/sign_account.dart';
import '../sign up/signup.dart';

class DiscoveryTab extends StatelessWidget {
  const DiscoveryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const DiscoveryTabHome();
  }
}

class DiscoveryTabHome extends StatefulWidget {
  const DiscoveryTabHome({super.key});

  @override
  State<DiscoveryTabHome> createState() => _DiscoveryTabHomeState();
}

class _DiscoveryTabHomeState extends State<DiscoveryTabHome> {
  final _userTextFile = TextEditingController();
  final _passwordTextFile = TextEditingController();

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Thông báo'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  void _handleLogin() async {
    final username = _userTextFile.text.trim();
    final password = _passwordTextFile.text;

    if (username.isEmpty || password.isEmpty) {
      _showDialog('Vui lòng nhập đầy đủ');
      return;
    }

    final success = await AccountDatabase.instance.checkLogin(username, password);
    if (success) {
      _showDialog('Đăng nhập thành công');

      // TODO: Tùy bạn xử lý điều hướng
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      _showDialog('Sai tài khoản hoặc mật khẩu');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Hình nền
          SizedBox.expand(
            child: Image.asset(
              'assets/background1.png',
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat,
            ),
          ),
          // Nội dung chính
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _userTextFile,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(),
                      labelText: 'Tên đăng nhập',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordTextFile,
                    obscureText: true,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(),
                      labelText: 'Mật khẩu',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )
                    ),
                    onPressed: _handleLogin,
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const SignUp(),
                          transitionsBuilder: (_, animation, __, child) {
                            final offsetAnimation = Tween(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut,
                            ));
                            return SlideTransition(position: offsetAnimation, child: child);
                          },
                        ),
                      );
                    },
                    child: const Text('Đăng ký'),
                  ),
                  const SizedBox(height: 20),
                  const Text('Hoặc đăng nhập bằng'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(onPressed: (){}, icon: const Icon(Icons.facebook), color: Colors.blue,),
                      const SizedBox(width: 12),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.g_mobiledata), color: Colors.red,),
                      const SizedBox(width: 12),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.apple), color: Colors.white,),
                      const SizedBox(width: 12),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.email), color: Colors.red,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}