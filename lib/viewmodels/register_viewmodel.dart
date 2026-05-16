import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class RegisterViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --- FUNGSI REGISTER (Menerima inputan berupa Objek User) ---
  Future<bool> registerUser(User newUser) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); 

    try {
      final prefs = await SharedPreferences.getInstance();

      // Simpan data ke SharedPreferences mengambil dari properti objek newUser yang dikirim dari UI
      await prefs.setString('name', newUser.username);
      await prefs.setString('email', newUser.email);
      
      if (newUser.password != null) {
        await prefs.setString('password', newUser.password!);
        
        // Sinkronisasi dengan key pencocokan login (registered_email & registered_password)
        await prefs.setString('registered_email', newUser.email);
        await prefs.setString('registered_password', newUser.password!);
      }

      _isLoading = false;
      notifyListeners(); // Beri tahu UI bahwa proses selesai
      return true;
    } catch (e) {
      _errorMessage = "Terjadi kesalahan saat menyimpan data pendaftaran.";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}