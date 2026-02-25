import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'modules/auth/login_screen.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Questionnaire App',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      getPages: AppPages.routes,

    );

  }
}