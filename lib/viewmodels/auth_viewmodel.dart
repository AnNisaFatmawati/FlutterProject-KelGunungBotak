import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --- FUNGSI LOGIN ---
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();

      // Ambil data pendaftaran
      final savedEmail = prefs.getString('email');
      final savedPassword = prefs.getString('password');

      await Future.delayed(const Duration(seconds: 1));

      // LOGIKA BARU: Cek data pendaftaran ATAU pakai akun rahasia Princess
      if ((savedEmail != null && email == savedEmail && password == savedPassword) ||
          (email == "nisa@gmail.com" && password == "123456")) { // <-- Akun cadangan

        await prefs.setBool('isLoggedIn', true);

        // Simpan data default kalau tadi login pakai akun cadangan tapi laci kosong
        if (savedEmail == null) {
          await prefs.setString('name', 'Nisa (Dev)');
          await prefs.setString('email', 'nisa@gmail.com');
        }

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Email atau password salah!";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "Terjadi kesalahan sistem";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // --- FUNGSI LOGOUT ---
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    notifyListeners();
  }
}