import 'package:get/get.dart';
import '../../modules/auth/login_screen.dart';
import '../../modules/home/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
    ),
  ];
}