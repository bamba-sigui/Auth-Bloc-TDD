import 'package:auth_bloc/features/authentification/presentation/pages/home_page.dart';
import 'package:auth_bloc/features/authentification/presentation/pages/signin_page.dart';
import 'package:auth_bloc/features/authentification/presentation/pages/splash_page.dart';
import 'package:get/get.dart';

class RoutesProvider {
  static const String start = '/';
  static const String onBoarding = '/on_start_screen';
  static const String phoneNumber = '/phone_number_verification';
  static const String homePage = '/home';
  static const String splashScreen = '/splash_screen';

  static List<GetPage<dynamic>> routes = [
    GetPage(name: start, page: () => const LoginPage()), //StartScreen
    GetPage(name: homePage, page: () => const HomePage()), //HomeScreen
    GetPage(name: splashScreen, page: () => const SplashPage()), //SplashScreen
  ];
}
