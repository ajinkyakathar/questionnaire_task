import 'package:get/get.dart';
import '../../modules/auth/login_screen.dart';
import '../../modules/home/home_screen.dart';
import 'app_routes.dart';
import '../../modules/auth/register_screen.dart';

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
    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
    ),
  ];
}