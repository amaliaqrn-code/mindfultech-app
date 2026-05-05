import 'package:flutter/material.dart';
import 'package:mindfultech_app/pages/registrasi_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindful Tech',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
      ),
      home: RegistrasiPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}