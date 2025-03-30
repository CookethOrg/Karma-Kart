import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:karmakart/screens/auth_screens/log_in.dart";
import 'dart:async';

import "../../core/theme/app_theme.dart";
import "../auth_screens/sign_up.dart";

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LogIn()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020315),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/logo.png",
              width: 250.w,
            ),
            SizedBox(height: 8.h),
            Text(
              "Karma Kart",
              style: TextStyle(
                color: Colors.white,
                fontSize: 80.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "Swap skills, level up",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF656678),
                fontWeight: FontWeight.w600,
                fontSize: 36.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
