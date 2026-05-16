import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';
import 'register_screen.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Pisahin fungsi login biar kodingan UI tetep bersih
  Future<void> _handleLogin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    // Ambil Koki (ViewModel) tanpa me-rebuild layar
    final authVM = context.read<AuthViewModel>();

    final success = await authVM.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!context.mounted) return;

    if (success) {
      // Pindah ke Home kalau sukses
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      // Munculin notif error merah dari ViewModel
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authVM.errorMessage ?? "Login gagal"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                const Text(
                    'Selamat Datang Kembali!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 10),
                const Text(
                    'Silakan masuk ke akun Anda.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey)
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Password wajib diisi' : null,
                ),
                const SizedBox(height: 50),

                // BUKTI MVVM JALAN: Consumer ditaruh khusus di tombol biar performa enteng
                SizedBox(
                  height: 55,
                  child: Consumer<AuthViewModel>(
                      builder: (context, authVM, child) {
                        return ElevatedButton(
                          // Kalau lagi loading, tombol disable (null)
                          onPressed: authVM.isLoading ? null : () => _handleLogin(context),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              disabledBackgroundColor: Colors.blue.shade300,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                          ),
                          child: authVM.isLoading
                              ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3)
                          )
                              : const Text('Masuk', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                        );
                      }
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun? '),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterScreen())
                      ),
                      child: const Text('Daftar di sini', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}