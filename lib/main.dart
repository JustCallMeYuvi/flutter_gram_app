import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/insta_home_screen.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('users');
  await Hive.openBox('reels');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Hive.box('users').get(
      'isLoggedIn',
      defaultValue: false,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const InstaHomeScreen() : const InstagramLoginScreen(),
    );
  }
}
