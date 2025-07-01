// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ThemeViewModel with ChangeNotifier {
//   static const _key = 'is_dark_mode';
//   bool _isDarkMode = false;
//
//   bool get isDarkMode => _isDarkMode;
//
//   ThemeViewModel() {
//     _loadTheme();
//   }
//
//   void _loadTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     _isDarkMode = prefs.getBool(_key) ?? false;
//     notifyListeners();
//   }
//
//   void toggleTheme(bool value) async {
//     _isDarkMode = value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_key, _isDarkMode);
//     notifyListeners();
//   }
// }
//


import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewModel with ChangeNotifier {
  static const _key = 'is_dark_mode';
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeViewModel() {
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_key) ?? false;
    notifyListeners();
  }

  void toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, value);
    _isDarkMode = value;
    notifyListeners();
  }
}