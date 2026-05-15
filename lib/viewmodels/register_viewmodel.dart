import 'package:shared_preferences/shared_preferences.dart';

class RegisterViewModel {
  Future<bool> registerUser(String name, String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Pakai label yang simpel dan seragam
      await prefs.setString('name', name);
      await prefs.setString('email', email);
      await prefs.setString('password', password);

      return true;
    } catch (e) {
      return false;
    }
  }
}