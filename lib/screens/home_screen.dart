import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'add_run_screen.dart';
import 'home_content.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> runs = [
    {"distance": 5.2, "duration": 30},
    {"distance": 3.5, "duration": 25},
    {"distance": 7.0, "duration": 45},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catat Lari',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const WelcomeScreen(),
                ),
              );
            },
          ),
        ],
      ),

      // 🔹 Body berubah sesuai tab
      body: _selectedIndex == 0
          ? HomeContent(runs: runs)
          : const ProfileScreen(),

      // 🔹 FAB hanya muncul di Beranda
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              tooltip: "Tambah Lari",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddRunScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,

      // 🔹 Bottom Navbar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}