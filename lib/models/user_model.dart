class User {
  final String username; // Menggunakan username agar sinkron dengan seluruh ViewModel
  final String email;
  final String? password;
  final String? profileImage;

  User({
    required this.username,
    required this.email,
    this.password,
    this.profileImage,
  });

  // Mengubah Objek User menjadi Map/JSON untuk disimpan ke local storage
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'profile_image': profileImage,
    };
  }

  // Membuat Objek User dari data Map/JSON (pembacaan dari local storage)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'],
      profileImage: json['profile_image'],
    );
  }
}