import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel {
  Future<bool> loginUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Ambil data yang tadi didaftarkan
    String? savedEmail = prefs.getString('registered_email');
    String? savedPassword = prefs.getString('registered_password');

    print("Mencoba login dengan: $email | $password");
    print("Data tersimpan: $savedEmail | $savedPassword");

    // Cek apakah cocok
    if (savedEmail != null && email == savedEmail && password == savedPassword) {
      await prefs.setBool('isLoggedIn', true);
      // Simpan nama biar di profil muncul
      String? name = prefs.getString('name');
      print("Login Berhasil! Selamat datang $name");
      return true;
    }

    print("Login Gagal: Data tidak cocok atau belum daftar.");
    return false;
  }
}