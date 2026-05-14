import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  List<User> _users = [];

  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // GETTERS
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  // INIT (load data saat app start)
  AuthViewModel() {
    loadUsers();
  }

  // ========================
  // LOAD & SAVE
  // ========================

  Future<void> loadUsers() async {
    final prefs = await SharedPreferences.getInstance();

    final userString = prefs.getString('users');

    if (userString != null) {
      final List decoded = jsonDecode(userString);
      _users = decoded.map((e) => User.fromJson(e)).toList();
    }

    final currentUserString = prefs.getString('currentUser');
    if (currentUserString != null) {
      _currentUser = User.fromJson(jsonDecode(currentUserString));
    }

    notifyListeners();
  }

  Future<void> _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();

    final userListJson = _users.map((u) => u.toJson()).toList();
    await prefs.setString('users', jsonEncode(userListJson));

    if (_currentUser != null) {
      await prefs.setString(
        'currentUser',
        jsonEncode(_currentUser!.toJson()),
      );
    } else {
      await prefs.remove('currentUser');
    }
  }

  // ========================
  // REGISTER
  // ========================

  Future<bool> register(String username, String email, String password) async {
    _setLoading(true);
    _clearError();

    await Future.delayed(const Duration(seconds: 1)); // simulasi

    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      _setError("Semua field harus diisi");
      _setLoading(false);
      return false;
    }

    if (!email.contains("@")) {
      _setError("Format email tidak valid");
      _setLoading(false);
      return false;
    }

    if (password.length < 6) {
      _setError("Password minimal 6 karakter");
      _setLoading(false);
      return false;
    }

    final exists = _users.any((u) => u.email == email);
    if (exists) {
      _setError("Email sudah terdaftar");
      _setLoading(false);
      return false;
    }

    final newUser = User(
      username: username,
      email: email,
      password: password,
    );

    _users.add(newUser);

    await _saveUsers();

    _setLoading(false);
    return true;
  }

  // ========================
  // LOGIN
  // ========================

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    await Future.delayed(const Duration(seconds: 1));

    try {
      final user = _users.firstWhere(
        (u) => u.email == email && u.password == password,
      );

    _currentUser = user;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true); // untuk simpan login

    await _saveUsers();

      _setLoading(false);
      return true;
    } catch (e) {
      _setError("Email atau password salah");
      _setLoading(false);
      return false;
    }
  }

  // ========================
  // LOGOUT
  // ========================

  Future<void> logout() async {
    _currentUser = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', false); // untuk simpan logout

    await _saveUsers();
    notifyListeners();
  }

  // ========================
  // HELPERS
  // ========================

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}