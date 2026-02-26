import 'package:get/get.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/home/home_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/questionnaire/questionnaire_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const questionnaire = '/questionnaire';
  static const profile = '/profile';

  static final pages = [
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: questionnaire, page: () => const QuestionnaireScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
  ];
}