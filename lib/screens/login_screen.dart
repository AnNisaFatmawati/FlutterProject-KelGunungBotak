import 'package:flutter/material.dart';
import 'register_screen.dart'; // Import halaman register biar bisa pindah

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Judul: Selamat Datang
              const Text(
                'Selamat Datang!',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              // 2. Subtitel
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: const Text(
                  'Silakan masuk ke akun Anda untuk melanjutkan aktivitas bersama kami.',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),

              // 3. Input Email
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Masukkan email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),

              // 4. Input Password
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Masukkan password',
                  border: OutlineInputBorder(),
                ),
              ),

              // Spacer() berfungsi untuk mendorong tombol ke bagian bawah layar
              const Spacer(),

              // 5. Tombol Masuk
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi login nanti di sini
                  },
                  child: const Text(
                    'Masuk',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // 6. Link ke halaman Daftar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum punya akun? '),
                  GestureDetector(
                    onTap: () {
                      // Pindah ke halaman Register
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text(
                      'Daftar di sini',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}