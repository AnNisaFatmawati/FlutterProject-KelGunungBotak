import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import screen kamu
import '../home/home_screen.dart';
import 'login_screen.dart'; // atau welcome_screen.dart

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
    final loginStatus = prefs.getBool('isLogin') ?? false;

    setState(() {
      isLogin = loginStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ⏳ loading dulu saat ngecek
    if (isLogin == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 🔀 redirect
    if (isLogin == true) {
      return const HomeScreen();
    } else {
      return const LoginScreen(); // atau WelcomeScreen
    }
  }
}