import 'package:booksapp/ui/home/home.dart';
import 'package:booksapp/ui/now_reading/viewbook.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      ChangeNotifierProvider(
      create: (context) => ThemeViewModel(),
  child: const BookApp())
  );
}
