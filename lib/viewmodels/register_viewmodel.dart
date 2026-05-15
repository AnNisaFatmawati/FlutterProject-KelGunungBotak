import 'package:shared_preferences/shared_preferences.dart';

class RegisterViewModel {
  Future<bool> registerUser(String name, String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
      await prefs.setString('email', email);

      return true; // Berhasil menyimpan
    } catch (e) {
      return false; // Gagal menyimpan
    }
  }
}