<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {
  String name = "User";
  String email = "user@gmail.com";

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    name = prefs.getString('name') ?? 'User';
    email = prefs.getString('email') ?? 'user@gmail.com';

    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  double getTotalDistance(List<Map<String, dynamic>> runs) {
    return runs.fold(0.0, (sum, run) {
      return sum + (run['distance'] ?? 0).toDouble();
    });
  }

  double getTotalDuration(List<Map<String, dynamic>> runs) {
    return runs.fold(0.0, (sum, run) {
      return sum + (run['duration'] ?? 0).toDouble();
    });
  }
=======
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel {
  // Mengambil data user dari memori
  Future<Map<String, String?>> loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name') ?? 'User',
      'email': prefs.getString('email') ?? 'user@gmail.com',
      'profile_image': prefs.getString('profile_image'),
    };
  }

  // Logika menghitung total jarak
  double calculateTotalDistance(List<Map<String, dynamic>> runs) {
    double total = 0;
    for (var run in runs) {
      total += (run['distance'] ?? 0).toDouble();
    }
    return total;
  }

  // Logika menghitung total waktu
  double calculateTotalDuration(List<Map<String, dynamic>> runs) {
    double total = 0;
    for (var run in runs) {
      total += (run['duration'] ?? 0).toDouble();
    }
    return total;
  }

  // Logika logout (menghapus status login)
  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }
>>>>>>> annisa-mvvm
}