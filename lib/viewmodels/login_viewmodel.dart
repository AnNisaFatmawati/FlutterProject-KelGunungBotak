import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --- FUNGSI LOGIN (Menerima inputan berupa Objek User) ---
  Future<bool> loginUser(User userInput) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    print("Mencoba login dengan: ${userInput.email} | ${userInput.password}");

    try {
      final prefs = await SharedPreferences.getInstance();

      // Ambil data yang tadi didaftarkan (menyesuaikan dengan key lama kodemu)
      String? savedName = prefs.getString('name');
      String? savedEmail = prefs.getString('registered_email');
      String? savedPassword = prefs.getString('registered_password');

      print("Data tersimpan di perangkat: $savedEmail | $savedPassword");

      await Future.delayed(const Duration(seconds: 1));

      // Cek apakah data inputan cocok dengan data yang terdaftar
      if (savedEmail != null && 
          userInput.email == savedEmail && 
          userInput.password == savedPassword) {
        
        await prefs.setBool('isLoggedIn', true);
        
        print("Login Berhasil! Selamat datang ${savedName ?? 'User'}");
        
        _isLoading = false;
        notifyListeners();
        return true;
      }

      // Jika data tidak cocok
      _errorMessage = "Email atau password salah atau belum terdaftar.";
      print("Login Gagal: $_errorMessage");
      _isLoading = false;
      notifyListeners();
      return false;

    } catch (e) {
      _errorMessage = "Terjadi kesalahan sistem";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}