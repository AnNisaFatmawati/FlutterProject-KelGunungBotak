# 🏃‍♂️ FlutterProject - Kelompok Gunung Botak

## 📌 Deskripsi Proyek
**KelGunungBotak TrackApp** adalah aplikasi pencatat aktivitas lari berbasis mobile yang dirancang untuk membantu pengguna melacak, mencatat, dan mengelola riwayat olahraga lari mereka secara efisien. Aplikasi ini mengadopsi arsitektur **MVVM (Model-View-ViewModel)** untuk memastikan kode yang bersih, terstruktur, mudah dipelihara, dan memiliki performa yang optimal di berbagai platform.

---

## 👥 Tim Pengembang
Aplikasi ini dikembangkan oleh kelompok mahasiswa dengan pembagian tugas sebagai berikut:

| Nama Lengkap | NPM | Fitur & Komponen yang Dibuat |
| :--- | :--- | :--- |
| **An Nisa' Fatmawati** | 24082010053 | Autentikasi (Halaman Login & Register) |
| **Talitha Nabila Candra** | 24082010061 | Halaman Beranda & Manajemen Profil (Edit Profil) |
| **Rindi Antika Qumalasari** | 24082010064 | Fitur Tambah Aktivitas Lari, Riwayat, & Halaman Profil |

---

## ✨ Fitur Utama dan Deskripsi
Aplikasi ini dilengkapi dengan berbagai fitur esensial untuk mendukung pengalaman pengguna dalam melacak aktivitas olahraga mereka:

1. **Welcome Screen**
   * Halaman penyambut interaktif saat pertama kali aplikasi dibuka sebelum masuk ke menu utama atau autentikasi.
2. **Sistem Autentikasi (Login & Register)**
   * Mengamankan akses pengguna ke aplikasi. Pengguna baru dapat mendaftar (*Register*) dan pengguna terdaftar dapat masuk (*Login*) untuk mengakses data personal mereka.
3. **Halaman Beranda (Dashboard)**
   * Pusat informasi utama yang menampilkan ringkasan aktivitas, statistik lari terakhir, dan navigasi cepat ke fitur lainnya.
4. **Fitur Tambah Aktivitas Lari**
   * Memungkinkan pengguna untuk mencatat metrik lari mereka secara manual, seperti jarak tempuh, durasi waktu, tanggal, dan catatan tambahan.
5. **Manajemen Riwayat Lari (Edit & Hapus)**
   * Pengguna dapat melihat daftar riwayat lari yang telah dilakukan serta mengubah (*edit*) atau memperbarui data aktivitas lari jika terjadi kesalahan input.
6. **Profil & Sinkronisasi Data**
   * Menampilkan informasi personal pengguna dan total pencapaian lari. Dilengkapi dengan fitur **Edit Profil** untuk memperbarui foto atau data diri secara sinkron.

---

## 🛠️ Tech Stack (Teknologi yang Digunakan)

Proyek ini dibangun menggunakan kombinasi teknologi modern untuk menghasilkan aplikasi cross-platform yang responsif:

* **Framework Utama:** [Flutter](https://flutter.dev/) - Framework UI open-source dari Google untuk membuat aplikasi kompilasi asli (native) untuk mobile, web, dan desktop dari satu basis kode.
* **Bahasa Pemrograman:** [Dart](https://dart.dev/) - Bahasa pemrograman yang dioptimalkan untuk pengembangan klien, digunakan sebagai bahasa utama dalam Flutter.
* **Arsitektur Kode:** **MVVM (Model-View-ViewModel)** - Pemisahan logika bisnis (ViewModel), data (Model), dan tampilan UI (View) untuk meningkatkan skalabilitas dan kemudahan pengujian kode (*unit testing*).
* **Multi-platform Support:** Aplikasi ini dikonfigurasi dan dioptimalkan agar dapat berjalan di lingkungan Android, iOS, Windows, macOS, Linux, dan Web.

---

## 📁 Struktur Proyek & Arsitektur MVVM

Berikut adalah gambaran struktur direktori utama di dalam folder `lib/`:

```text
lib/
├── models/
│   └── user_model.dart              # Blueprint data user
│
├── viewmodels/                      # Logika bisnis & state management
│   ├── auth_viewmodel.dart
│   ├── edit_profile_viewmodel.dart
│   ├── login_viewmodel.dart
│   ├── profile_viewmodel.dart
│   ├── register_viewmodel.dart
│   └── run_viewmodel.dart
│
├── views/
│   ├── auth/
│   │   ├── auth_wrapper.dart
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   └── welcome_screen.dart
│   │
│   ├── home/
│   │   ├── add_run_screen.dart
│   │   ├── home_content.dart
│   │   └── home_screen.dart
│   │
│   └── profile/
│       ├── edit_profile_screen.dart
│       └── profile_screen.dart
│
└── main.dart                        # Entry point aplikasi Flutter
