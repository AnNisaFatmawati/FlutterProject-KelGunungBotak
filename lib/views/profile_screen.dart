import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../viewmodels/profile_viewmodel.dart';
import 'welcome_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final List<Map<String, dynamic>> runs;

  const ProfileScreen({super.key, required this.runs});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileViewModel _viewModel = ProfileViewModel();

  String name = "User";
  String email = "user@gmail.com";
  String? _base64Image;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  // Mengambil data
  Future<void> _fetchProfileData() async {
    final data = await _viewModel.loadUserProfile();
    setState(() {
      name = data['name']!;
      email = data['email']!;
      _base64Image = data['profile_image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    if (_base64Image != null) {
      imageBytes = base64Decode(_base64Image!);
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color(0xFFE3F2FD),
                  backgroundImage: imageBytes != null ? MemoryImage(imageBytes) : null,
                  child: imageBytes == null ? const Icon(Icons.person, size: 40, color: Colors.blue) : null,
                ),
                const SizedBox(height: 12),
                Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(email, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text("Jarak", style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 5),
                        // Memanggil perhitungan dari ViewModel
                        Text("${_viewModel.calculateTotalDistance(widget.runs)} km", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("Waktu", style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 5),
                        // Memanggil perhitungan dari ViewModel
                        Text("${_viewModel.calculateTotalDuration(widget.runs)} menit", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("Hari", style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 5),
                        Text("${widget.runs.length}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                          );
                          if (result == true) _fetchProfileData();
                        },
                        child: const Text("Edit Profile", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Konfirmasi Logout"),
                              content: const Text("Apakah Anda yakin ingin keluar?"),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
                                TextButton(
                                  onPressed: () async {
                                    // Memanggil logika logout dari ViewModel
                                    await _viewModel.logoutUser();
                                    if (!context.mounted) return;
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                                          (route) => false,
                                    );
                                  },
                                  child: const Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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