import 'package:flutter/material.dart';
<<<<<<<< HEAD:lib/views/auth/register_screen.dart
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';
========
import '../viewmodels/register_viewmodel.dart'; // Memanggil si Koki (ViewModel)
>>>>>>>> annisa-mvvm:lib/views/register_screen.dart
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
  final _confirmPasswordController = TextEditingController();

  // Memanggil instance dari ViewModel
  final RegisterViewModel _viewModel = RegisterViewModel();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final authVM = context.read<AuthViewModel>();

    final success = await authVM.register(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (success) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(
            'Pendaftaran Berhasil',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Akun Anda berhasil dibuat. Silakan login.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authVM.errorMessage ?? 'Register gagal'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();

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
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Lengkapi data di bawah ini untuk bergabung bersama Catat Lari.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 40),

<<<<<<<< HEAD:lib/views/auth/register_screen.dart
                  // Nama
========
>>>>>>>> annisa-mvvm:lib/views/register_screen.dart
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
<<<<<<<< HEAD:lib/views/auth/register_screen.dart
                    validator: (value) =>
                        value!.isEmpty ? 'Nama wajib diisi' : null,
                  ),
                  const SizedBox(height: 20),

                  // Email
========
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Nama Lengkap wajib diisi.';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

>>>>>>>> annisa-mvvm:lib/views/register_screen.dart
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    validator: (value) {
<<<<<<<< HEAD:lib/views/auth/register_screen.dart
                      if (value == null || value.isEmpty) {
                        return 'Email wajib diisi';
                      }
                      if (!value.contains('@')) {
                        return 'Email tidak valid';
                      }
========
                      if (value == null || value.isEmpty) return 'Email wajib diisi.';
                      if (!value.contains('@')) return 'Format email tidak valid.';
>>>>>>>> annisa-mvvm:lib/views/register_screen.dart
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

<<<<<<<< HEAD:lib/views/auth/register_screen.dart
                  // Password
========
>>>>>>>> annisa-mvvm:lib/views/register_screen.dart
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
<<<<<<<< HEAD:lib/views/auth/register_screen.dart
                    validator: (value) =>
                        value!.length < 6 ? 'Minimal 6 karakter' : null,
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password
========
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Password wajib diisi.';
                      if (value.length < 6) return 'Password minimal terdiri dari 6 karakter.';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

>>>>>>>> annisa-mvvm:lib/views/register_screen.dart
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Konfirmasi Password',
                      prefixIcon: Icon(Icons.lock_reset_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    validator: (value) {
<<<<<<<< HEAD:lib/views/auth/register_screen.dart
                      if (value != _passwordController.text) {
                        return 'Password tidak cocok';
                      }
========
                      if (value == null || value.isEmpty) return 'Konfirmasi Password wajib diisi.';
                      if (value != _passwordController.text) return 'Konfirmasi Password tidak sesuai.';
>>>>>>>> annisa-mvvm:lib/views/register_screen.dart
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),

<<<<<<<< HEAD:lib/views/auth/register_screen.dart
                  // Button
                  SizedBox(
========
                  Container(
>>>>>>>> annisa-mvvm:lib/views/register_screen.dart
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
<<<<<<<< HEAD:lib/views/auth/register_screen.dart
                      onPressed:
                          authVM.isLoading ? null : () => _handleRegister(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 6,
========
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {

                          // 🔥 Panggil Koki (ViewModel) untuk mengeksekusi simpan data
                          bool isSuccess = await _viewModel.registerUser(
                            _nameController.text,
                            _emailController.text,
                          );

                          if (!context.mounted) return;

                          if (isSuccess) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  title: const Text('Pendaftaran Berhasil', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                  content: const Text('Akun Anda telah berhasil didaftarkan ke dalam sistem. Silakan masuk untuk melanjutkan.', textAlign: TextAlign.center),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(dialogContext);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text('OK', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        elevation: 0,
>>>>>>>> annisa-mvvm:lib/views/register_screen.dart
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
<<<<<<<< HEAD:lib/views/auth/register_screen.dart
                      child: authVM.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Daftar Sekarang",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
========
                      child: const Text(
                        "Daftar Sekarang",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                      ),
>>>>>>>> annisa-mvvm:lib/views/register_screen.dart
                    ),
                  ),
                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah punya akun? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Masuk di sini',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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