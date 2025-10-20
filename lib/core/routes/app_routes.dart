import 'package:flutter/material.dart';
import 'package:metgo/core/widgets/app_scaffold.dart';
import 'package:metgo/features/auth/presentation/login_screen.dart';


class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    home: (context) => const AppScaffold(),
  };
}
