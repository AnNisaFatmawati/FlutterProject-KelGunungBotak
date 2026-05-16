import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/run_model.dart';

class ProfileViewModel extends ChangeNotifier {
  
  // === 1. MENGAMBIL DATA USER PROFILE ===
  Future<User> loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Mengambil data dari SharedPreferences dan membungkusnya ke dalam Objek User
    return User(
      username: prefs.getString('name') ?? 'User',
      email: prefs.getString('email') ?? 'user@gmail.com',
      profileImage: prefs.getString('profile_image'),
    );
  }

  // === 2. MENGHITUNG TOTAL JARAK (Menerima List<RunModel>) ===
  double calculateTotalDistance(List<RunModel> runs) {
    double total = 0;
    for (var run in runs) {
      total += run.distance; // Jauh lebih aman, langsung akses property objek
    }
    return total;
  }

  // === 3. MENGHITUNG TOTAL WAKTU DALAM MENIT (Menerima List<RunModel>) ===
  double calculateTotalDuration(List<RunModel> runs) {
    double totalMinutes = 0;
    
    for (var run in runs) {
      // Membedah format string durasi (Contoh format: "HH:mm:ss" atau "mm:ss")
      final parts = run.duration.split(':');
      
      if (parts.length == 3) {
        // Jika format HH:mm:ss
        int hours = int.tryParse(parts[0]) ?? 0;
        int minutes = int.tryParse(parts[1]) ?? 0;
        int seconds = int.tryParse(parts[2]) ?? 0;
        totalMinutes += (hours * 60) + minutes + (seconds / 60);
      } else if (parts.length == 2) {
        // Jika format mm:ss
        int minutes = int.tryParse(parts[0]) ?? 0;
        int seconds = int.tryParse(parts[1]) ?? 0;
        totalMinutes += minutes + (seconds / 60);
      }
    }
    return totalMinutes; // Mengembalikan total waktu dalam satuan Menit
  }

  // === 4. LOGOUT ===
  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Set status login jadi false
    notifyListeners();
  }
}