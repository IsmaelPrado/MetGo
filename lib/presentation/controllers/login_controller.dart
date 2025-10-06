import 'package:flutter/material.dart';
import 'package:metgo/data/services/auth_service.dart';
import 'package:metgo/data/services/session_service.dart';
import 'package:metgo/core/routes/app_routes.dart';

class LoginController {
  final AuthService _authService = AuthService();
  final SessionService _sessionService = SessionService();

  Future<void> login(BuildContext context, String email, String password) async {
    bool success = await _authService.login(email, password);

    if (success) {
      await _sessionService.saveSession('dummy_token_123'); // token simulado
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales incorrectas')),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    await _sessionService.clearSession();
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }
}
