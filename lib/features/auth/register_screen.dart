import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/db_helper.dart';
import '../../core/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController(text: "+91");
  final pass = TextEditingController();
  final confirm = TextEditingController();

  bool validEmail(String e) =>
      RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(e);

  bool validPhone(String p) =>
      RegExp(r'^\+91[0-9]{10}$').hasMatch(p);

  bool validPassword(String p) =>
      RegExp(r'^(?=.*[!@#\$&*~]).{6,}$').hasMatch(p);

  void register() async {
    if (!validEmail(email.text)) {
      Get.snackbar("Error", "Enter valid email");
      return;
    }

    if (!validPhone(phone.text)) {
      Get.snackbar("Error", "Phone must be +91XXXXXXXXXX");
      return;
    }

    if (!validPassword(pass.text)) {
      Get.snackbar("Error", "Password needs special character");
      return;
    }

    if (pass.text != confirm.text) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    await DBHelper.registerUser(
        name.text, email.text, phone.text, pass.text);

    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff3f51b5), Color(0xff2196f3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Create Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      TextField(controller: name, decoration: const InputDecoration(labelText: "Name")),
                      const SizedBox(height: 12),
                      TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),
                      const SizedBox(height: 12),
                      TextField(controller: phone, decoration: const InputDecoration(labelText: "Phone")),
                      const SizedBox(height: 12),
                      TextField(controller: pass, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
                      const SizedBox(height: 12),
                      TextField(controller: confirm, obscureText: true, decoration: const InputDecoration(labelText: "Confirm Password")),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Register"),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text("Already have an account? Login"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}