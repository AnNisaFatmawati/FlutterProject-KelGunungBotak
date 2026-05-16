import 'package:flutter/material.dart';
import '../../viewmodels/register_viewmodel.dart';
import '../../models/user_model.dart'; // Tambahkan import User model
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController(); // Kalau mau dipakai nanti

  // Inisialisasi ViewModel
  final RegisterViewModel _viewModel = RegisterViewModel();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _viewModel.dispose(); // Jangan lupa bersihkan memori ViewModel
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Daftar Akun Baru", 
                    textAlign: TextAlign.center, 
                    style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap', 
                      prefixIcon: Icon(Icons.person_outline), 
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Nama wajib diisi' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email', 
                      prefixIcon: Icon(Icons.email_outlined), 
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    validator: (value) => value == null || !value.contains('@') ? 'Email tidak valid' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password', 
                      prefixIcon: Icon(Icons.lock_outline), 
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    validator: (value) => value == null || value.length < 6 ? 'Minimal 6 karakter' : null,
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // 1. Bungkus data inputan ke dalam objek model User sesuai kesepakatan
                        User newUser = User(
                          username: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text, // Menyertakan password untuk pendaftaran
                        );

                        // 2. Kirim objek model User ke ViewModel
                        bool success = await _viewModel.registerUser(newUser);
                        
                        if (success && context.mounted) {
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, 
                      foregroundColor: Colors.white, 
                      padding: const EdgeInsets.symmetric(vertical: 15), 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text(
                      "Daftar Sekarang", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}