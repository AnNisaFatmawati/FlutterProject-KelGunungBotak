import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {
  // Fungsi 1: Mengambil data user (Nama, Email, Foto)
  Future<Map<String, String?>> loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name') ?? 'User',
      'email': prefs.getString('email') ?? 'user@gmail.com',
      'profile_image': prefs.getString('profile_image'),
    };
  }

  // Fungsi 2: Hitung Total Jarak
  double calculateTotalDistance(List<Map<String, dynamic>> runs) {
    double total = 0;
    for (var run in runs) {
      // Pastikan mengambil data 'distance' dan konversi ke double
      total += (run['distance'] ?? 0).toDouble();
    }
    return total;
  }

  // Fungsi 3: Hitung Total Waktu
  double calculateTotalDuration(List<Map<String, dynamic>> runs) {
    double total = 0;
    for (var run in runs) {
      // Pastikan mengambil data 'duration' dan konversi ke double
      total += (run['duration'] ?? 0).toDouble();
    }
    return total;
  }

  // Fungsi 4: Logout
  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Set status login jadi false
    notifyListeners();
  }
}