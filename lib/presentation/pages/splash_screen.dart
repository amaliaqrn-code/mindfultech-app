import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isSecond = false;

  @override
  void initState() {
    super.initState();

    // Splash 1 → Splash 2
    Timer(Duration(seconds: 2), () {
      setState(() {
        isSecond = true;
      });
    });

    // Splash 2 → Onboarding
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSecond ? splashGradient() : splashWhite(),
    );
  }

  // 🔹 Splash pertama (putih)
  Widget splashWhite() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'assets/images/splashScreen1.png',
          width: 120,
        ),
      ),
    );
  }

  // 🔹 Splash kedua (gradient)
  Widget splashGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF7BC6CC),
            Color(0xFFBE93C5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/splashScreen2.png',
          width: 120,
        ),
      ),
    );
  }
}