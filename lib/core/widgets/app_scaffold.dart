import 'package:flutter/material.dart';
import 'package:metgo/core/widgets/bottom_nav_bar.dart';
import 'package:metgo/features/home/presentation/home_screen.dart';
import 'package:metgo/features/profile/presentation/profile_screen.dart';
import 'package:metgo/features/auth/data/services/session_service.dart';
import 'package:metgo/core/routes/app_routes.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final SessionService _sessionService = SessionService();
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  Future<void> _logout(BuildContext context) async {
    await _sessionService.clearSession();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
