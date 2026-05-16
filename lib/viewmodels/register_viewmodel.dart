import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart'; // <-- INI YANG BIKIN TERHUBUNG

class RegisterViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> registerUser(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // 1. BUKTI MVVM TERHUBUNG: Bungkus data ke dalam Model dulu!
      final User newUser = User(
        name: name,
        email: email,
        password: password,
      );

      final prefs = await SharedPreferences.getInstance();

      // 2. Simpan data yang diambil DARI MODEL, bukan langsung dari parameter layar
      await prefs.setString('name', newUser.name);
      await prefs.setString('email', newUser.email);
      await prefs.setString('password', newUser.password);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Gagal menyimpan data pendaftaran!";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}