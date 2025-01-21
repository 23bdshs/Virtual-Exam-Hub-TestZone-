
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:onlineexam/View/quiz/Screen/quiz_screen.dart';
import 'package:get/get.dart';
import 'package:onlineexam/View/splash.dart';
import 'package:onlineexam/View/login.dart';
import 'package:onlineexam/View/registration.dart';
import 'package:onlineexam/View/leaderboard.dart';
import 'package:onlineexam/View/control.dart';

void main() async {
  await Hive.initFlutter(); // Initialize Hive
  await Hive.openBox('userBox'); // Open a box for user data
  runApp(MyApp());
}

// This widget is the root of your application.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/Quiz', page: () => QuizScreen()),
        GetPage(name: '/log', page: () => LoginPage()),
        GetPage(name: '/reg', page: () => RegisterScreen()),
        GetPage(name: '/leaderboard', page: () => Leaderboard()),
        GetPage(name: '/control', page: () => control()),
      ],
    );
  }
}