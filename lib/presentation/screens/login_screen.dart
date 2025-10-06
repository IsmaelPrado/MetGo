import 'package:flutter/material.dart';
import 'package:metgo/presentation/widgets/custom_button.dart';
import 'package:metgo/presentation/widgets/custom_text_field.dart';
import 'package:metgo/presentation/controllers/login_controller.dart';
import 'package:metgo/core/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Iniciar sesión',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                validator: Validators.email,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _passwordController,
                label: 'Contraseña',
                obscureText: true,
                validator: Validators.password,
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: 'Ingresar',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _controller.login(
                      context,
                      _emailController.text,
                      _passwordController.text,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
