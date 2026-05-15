import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel {
  // Memproses logika login dan simpan data
  Future<bool> loginUser(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', email);

      // Mengambil nama dari depan email
      String? currentName = prefs.getString('name');
      if (currentName == null || currentName == 'User' || currentName.isEmpty) {
        String nameFromEmail = email.split('@')[0];
        await prefs.setString('name', nameFromEmail);
      }

      return true; // Mengembalikan nilai true jika proses berhasil
    } catch (e) {
      return false; // Mengembalikan nilai false jika ada error
    }
  }
}