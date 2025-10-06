import 'package:flutter/material.dart';
import 'package:metgo/presentation/screens/login_screen.dart';
import 'package:metgo/presentation/screens/home_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
  };
}
