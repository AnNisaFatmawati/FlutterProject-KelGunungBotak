import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --- FUNGSI LOGIN (Menerima inputan berupa Objek User) ---
  Future<bool> login(User userInput) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();

      // Ambil data pendaftaran lokal dari SharedPreferences
      final savedName = prefs.getString('name');
      final savedEmail = prefs.getString('email');
      final savedPassword = prefs.getString('password');
      final savedImage = prefs.getString('profile_image');

      await Future.delayed(const Duration(seconds: 1));

      // Membuat objek User dari data yang tersimpan di laci local memory
      User? savedUser;
      if (savedEmail != null && savedPassword != null) {
        savedUser = User(
          username: savedName ?? 'User',
          email: savedEmail,
          password: savedPassword,
          profileImage: savedImage,
        );
      }

      // LOGIKA BARU: Cek data pendaftaran ATAU pakai akun rahasia dev
      bool isRegisteredUser = savedUser != null && 
          userInput.email == savedUser.email && 
          userInput.password == savedUser.password;

      bool isDevUser = userInput.email == "nisa@gmail.com" && 
          userInput.password == "123456";

      if (isRegisteredUser || isDevUser) {
        await prefs.setBool('isLoggedIn', true);

        // Simpan data default kalau tadi login pakai akun cadangan/dev tapi laci masih kosong
        if (savedUser == null && isDevUser) {
          await prefs.setString('name', 'Nisa (Dev)');
          await prefs.setString('email', 'nisa@gmail.com');
          await prefs.setString('password', '123456'); // Sesuai Pendekatan B, password disimpan jika dibutuhkan
        }

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Email atau password salah!";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "Terjadi kesalahan sistem";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // --- FUNGSI REGISTER / DAFTAR BARU ---
  // Ditambahkan sekalian jika halaman register kamu nanti juga membutuhkannya
  Future<bool> register(User newUser) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Simpan data pendaftaran baru dari objek User ke memori lokal
      await prefs.setString('name', newUser.username);
      await prefs.setString('email', newUser.email);
      
      if (newUser.password != null) {
        await prefs.setString('password', newUser.password!);
      }
      if (newUser.profileImage != null) {
        await prefs.setString('profile_image', newUser.profileImage!);
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Gagal melakukan pendaftaran";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // --- FUNGSI LOGOUT ---
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    notifyListeners();
  }
}