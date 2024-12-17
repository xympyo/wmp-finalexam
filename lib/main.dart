import 'package:final_exam_project/pages/enrollment_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:final_exam_project/pages/login_page.dart';
import 'package:final_exam_project/pages/register_page.dart';
import 'package:final_exam_project/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/login-page': (context) => const LoginPage(),
        '/register-page': (context) => const RegisterPage(),
        '/enrollment-page': (context) => const EnrollmentPage(),
      },
    );
  }
}
