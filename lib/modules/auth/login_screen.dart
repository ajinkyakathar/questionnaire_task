import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to Home screen
            Get.toNamed(Routes.home);
          },
          child: const Text("Go To Home"),
        ),
      ),
    );
  }
}