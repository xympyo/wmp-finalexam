import 'dart:async';

import 'package:final_exam_project/shared/theme.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/login-page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 216,
              height: 216,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/logo_pu.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'PUIS',
              style: blackTextStyle.copyWith(
                fontSize: 72,
                fontWeight: thin,
                letterSpacing: 21.60,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'ENROLLMENT',
              style: blackTextStyle.copyWith(
                fontSize: 32,
                fontWeight: light,
                letterSpacing: 3.20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
