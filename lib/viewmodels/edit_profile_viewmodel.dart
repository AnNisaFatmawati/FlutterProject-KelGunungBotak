import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class EditProfileViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // === 1. MEMANGGIL DATA PROFIL AWAL (Mengembalikan Objek User) ===
  Future<User> loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Membaca data lokal dan membungkusnya ke dalam Model User
    return User(
      username: prefs.getString('name') ?? '',
      email: prefs.getString('email') ?? '',
      password: prefs.getString('password'), // Membaca password jika dibutuhkan oleh sistem login
      profileImage: prefs.getString('profile_image'),
    );
  }

  // === 2. MENYIMPAN DATA PROFIL BARU (Menerima Objek User) ===
  Future<bool> saveProfileData(User user) async {
    _isLoading = true;
    notifyListeners(); // Beri tahu UI untuk menampilkan loading spinner

    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Simpan data ke SharedPreferences dari properti milik objek User
      await prefs.setString('name', user.username);
      await prefs.setString('email', user.email);

      if (user.profileImage != null) {
        await prefs.setString('profile_image', user.profileImage!);
      }
      
      // Jika password di dalam objek User ikut diubah, simpan juga ke memori lokal
      if (user.password != null && user.password!.isNotEmpty) {
        await prefs.setString('password', user.password!);
      }

      _isLoading = false;
      notifyListeners(); // Beri tahu UI bahwa proses simpan selesai
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}