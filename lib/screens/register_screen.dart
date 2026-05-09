import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar ini otomatis memberikan tombol Back bawaan, tapi kita bikin lebih tegas
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Perintah untuk kembali ke halaman sebelumnya (Login)
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Judul
                const Text(
                  "Daftar Akun",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                // 2. Subtitel
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    "Bergabunglah bersama kami! Silakan isi data di bawah ini untuk membuat akun baru.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // 3. Input Nama
                const TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "Masukkan nama Anda",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                // 4. Input Email
                const TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Masukkan email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                // 5. Input Password
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Masukkan password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                // 6. Input Ulang Password
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Masukkan ulang password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),

                // 7. Tombol Daftar
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Aksi daftar nanti di sini
                    },
                    child: const Text(
                      "Daftar",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // 8. Link kembali ke halaman Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sudah punya akun? '),
                    GestureDetector(
                      onTap: () {
                        // Kembali ke halaman Login
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Masuk di sini',
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
      ),
    );
  }
}