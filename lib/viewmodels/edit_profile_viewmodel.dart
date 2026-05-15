import 'package:shared_preferences/shared_preferences.dart';

class EditProfileViewModel {
  // Logika memanggil data sebelum diedit
  Future<Map<String, String?>> loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name') ?? '',
      'email': prefs.getString('email') ?? '',
      'profile_image': prefs.getString('profile_image'),
    };
  }

  // Logika menyimpan data yang sudah diedit
  Future<bool> saveProfileData(String name, String email, String? base64Image) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
      await prefs.setString('email', email);

      if (base64Image != null) {
        await prefs.setString('profile_image', base64Image);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}