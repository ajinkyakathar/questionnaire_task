import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'modules/auth/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Questionnaire App',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}