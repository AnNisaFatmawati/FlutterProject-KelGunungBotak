import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../viewmodels/edit_profile_viewmodel.dart';
import '../../models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final EditProfileViewModel _viewModel = EditProfileViewModel();

  String _initialName = '';
  String _initialEmail = '';
  String? _base64Image;
  bool _isModified = false;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
    _nameController.addListener(_checkModifications);
    _emailController.addListener(_checkModifications);
  }

  Future<void> _fetchInitialData() async {
    // Memuat profil yang dikembalikan dalam bentuk objek User dari ViewModel
    final user = await _viewModel.loadInitialData();
    setState(() {
      _initialName = user.username;
      _initialEmail = user.email;
      _base64Image = user.profileImage;
      _nameController.text = _initialName;
      _emailController.text = _initialEmail;
    });
  }

  void _checkModifications() {
    bool isTextModified = _nameController.text != _initialName || _emailController.text != _initialEmail;
    if (isTextModified != _isModified) {
      setState(() => _isModified = isTextModified);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _base64Image = base64Encode(bytes);
        _isModified = true; // Langsung aktif jika foto diganti
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    if (_base64Image != null) imageBytes = base64Decode(_base64Image!);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Bagian Foto Profil
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: imageBytes != null ? MemoryImage(imageBytes) : null,
                      child: imageBytes == null ? const Icon(Icons.person, size: 50, color: Colors.grey) : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Input Nama
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
              const SizedBox(height: 20),

              // Input Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
              const SizedBox(height: 40),

              // Tombol Simpan
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: _isModified
                      ? [
                          BoxShadow(
                            color: Colors.blue.withAlpha(100),
                            blurRadius: 12,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : [],
                ),
                child: ElevatedButton(
                  onPressed: _isModified ? () async {
                    if (_formKey.currentState!.validate()) {
                      // Bungkus data pembaruan ke dalam objek model User
                      final updatedUser = User(
                        username: _nameController.text,
                        email: _emailController.text,
                        profileImage: _base64Image,
                      );

                      await _viewModel.saveProfileData(updatedUser);
                      if (mounted) Navigator.pop(context, true);
                    }
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isModified ? Colors.blue : Colors.grey.shade400,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    disabledForegroundColor: Colors.grey.shade600,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 0,
                  ),
                  child: const Text("Simpan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}