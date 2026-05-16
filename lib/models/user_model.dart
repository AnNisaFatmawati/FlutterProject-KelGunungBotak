class User {
  final String name; // Disinkronkan dengan RegisterViewModel
  final String email;
  final String? password;     // Dibuat opsional agar tidak wajib selalu di-load
  final String? profileImage; // Menampung data foto profil Base64

  User({
    required this.name,
    required this.email,
    this.password,
    this.profileImage,
  });

  // Mengubah Objek User menjadi Map/JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      if (password != null) 'password': password, // Hanya disimpan jika ada nilainya
      'profileImage': profileImage,
    };
  }

  // Mengambil data dari Map/JSON menjadi Objek User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'], // Diambil jika ada di memori lokal
      profileImage: json['profileImage'],
    );
  }
}