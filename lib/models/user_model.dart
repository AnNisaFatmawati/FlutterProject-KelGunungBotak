class User {
  final String name; // Disinkronkan dengan RegisterViewModel
  final String email;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.password,
  });

  // Convert ke JSON (buat nyimpen data ke API / Memori lokal yang kompleks)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Ambil dari JSON (buat narik data dari API / Memori lokal)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '', // Pengaman: kalau null, isinya string kosong
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
}