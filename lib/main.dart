import 'package:flutter/material.dart';
import 'package:metgo/core/routes/app_routes.dart';
import 'package:metgo/data/services/session_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SessionService _sessionService = SessionService();
  String _initialRoute = AppRoutes.login;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    bool active = await _sessionService.isSessionActive();
    setState(() {
      _initialRoute = active ? AppRoutes.home : AppRoutes.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Login Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: _initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
