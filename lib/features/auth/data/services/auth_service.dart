class AuthService {
  Future<bool> login(String email, String password) async {
    // Simulación de autenticación
    await Future.delayed(const Duration(seconds: 1));

    if (email == "test" && password == "123456") {
      return true;
    }
    return false;
  }
}
