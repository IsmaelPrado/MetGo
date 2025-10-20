import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _keyToken = 'session_token';
  static const String _keyLoginTime = 'login_time';
  static const int _sessionDurationMinutes = 1; // tiempo de sesión

  /// Guarda token y tiempo de inicio de sesión
  Future<void> saveSession(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyLoginTime, DateTime.now().toIso8601String());
  }

  /// Verifica si la sesión sigue siendo válida
  Future<bool> isSessionActive() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_keyToken);
    final loginTimeStr = prefs.getString(_keyLoginTime);

    if (token == null || loginTimeStr == null) return false;

    final loginTime = DateTime.parse(loginTimeStr);
    final now = DateTime.now();

    final difference = now.difference(loginTime).inMinutes;

    return difference < _sessionDurationMinutes;
  }

  /// Cierra sesión manual o automática
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyLoginTime);
  }

  /// Obtiene el token actual (si lo necesitas)
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }
}
