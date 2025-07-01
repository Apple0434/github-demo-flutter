

import 'dart:core';

import 'package:booksapp/ui/now_reading/viewbook.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});


  @override
  Widget build(BuildContext context) {
    return const AccountTabHome();
  }
}


class AccountTabHome extends StatefulWidget {
  const AccountTabHome({super.key});

  @override
  State<AccountTabHome> createState() => _AccountTabHomeState();
}

class _AccountTabHomeState extends State<AccountTabHome> {
  bool _notificationEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationPreference();
  }

  Future<void> _loadNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationEnabled = prefs.getBool('notifications_enabled') ?? true;
    });
  }

  Future<void> _setNotificationPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
    setState(() {
      _notificationEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cài đặt"),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("Chung", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          SwitchListTile(
            title: const Text("Thông báo"),
            value: _notificationEnabled,
            onChanged: (value) {
              _setNotificationPreference(value);
              // TODO: xử lý bật/tắt thông báo
            },
          ),
          ListTile(
            title: const Text("Ngôn ngữ"),
            subtitle: const Text("Tiếng Việt"),
            leading: const Icon(Icons.language),
            onTap: () {
              // TODO: mở màn hình chọn ngôn ngữ
            },
          ),
          ListTile(
            title: const Text("Chế độ tối"),
            leading:  Icon(Icons.dark_mode),
            trailing: Consumer<ThemeViewModel>(
                builder: (context, themeVN, child) {
                    return Switch(
                        value: themeVN.isDarkMode,
                        onChanged: (value) {
                            themeVN.toggleTheme(value);
                        },
                    );
                },
            ),
          ),
                // TODO: chuyển đổi theme
          const Divider(),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("Tài khoản", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          ListTile(
            title: const Text("Thông tin tài khoản"),
            leading: const Icon(Icons.person),
            onTap: () {
              // TODO: mở trang thông tin tài khoản
            },
          ),
          ListTile(
            title: const Text("Đăng xuất"),
            leading: const Icon(Icons.logout),
            onTap: () {
              // TODO: xử lý đăng xuất
            },
          ),
          ListTile(
            title: const Text('Về chúng tôi'),
            leading: const Icon(Icons.info),
            onTap: () {
              // TODO: xử lý mở trang thông tin về chúng tôi
            },
          ),
          ListTile(
            title: const Text('Điều khoản sử dụng'),
            leading: const Icon(Icons.description),
            onTap: () {
              // TODO: xử lý mở trang điều khoản sử dụng
            },
          ),
          ListTile(
              title: const Text('Lỗi vui lòng nhấp vào đây'),
              leading: const Icon(Icons.error_sharp),
              onTap: () {}
          )
        ],
      ),
    );
  }
}




