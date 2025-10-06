import 'dart:async';
import 'package:flutter/material.dart';
import 'package:metgo/data/services/session_service.dart';
import 'package:metgo/core/routes/app_routes.dart';
import 'package:metgo/presentation/widgets/custom_button.dart'; // importamos el custom button

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SessionService _sessionService = SessionService();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startSessionCheck();
  }

  void _startSessionCheck() {
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) async {
      bool active = await _sessionService.isSessionActive();
      if (!active) {
        await _sessionService.clearSession();
        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      }
    });
  }

  Future<void> _logout() async {
    await _sessionService.clearSession();
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenido')),
      body: Center(
        child: CustomButton(
          text: 'Cerrar sesión',
          onPressed: _logout,
        ),
      ),
    );
  }
}
