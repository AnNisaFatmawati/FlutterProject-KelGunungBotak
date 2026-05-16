import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home_screen.dart';
import 'welcome_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool? isLogin;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    // Menyelaraskan key dengan ViewModel yang digunakan di seluruh aplikasi
    final loginStatus = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;
    setState(() {
      isLogin = loginStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.blue)),
      );
    }

    if (isLogin == true) {
      return const HomeScreen(); 
    } else {
      return const WelcomeScreen();
    }
  }
}