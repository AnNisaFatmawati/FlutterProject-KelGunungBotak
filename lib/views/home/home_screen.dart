import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/run_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../models/run_model.dart'; // Tambahkan import model lari

import '../auth/welcome_screen.dart';
import '../home/add_run_screen.dart';
import '../home/home_content.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final runVM = context.watch<RunViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? "Catat Lari" : "Profil",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),

      body: _selectedIndex == 0
          ? HomeContent(runs: runVM.runs) 
          : ProfileScreen(runs: runVM.runs),

      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddRunScreen(),
                  ),
                );

                if (result != null) {
                  // Validasi: Jika data yang dikembalikan dari AddRunScreen masih berupa Map,
                  // ubah terlebih dahulu menjadi objek RunModel sebelum ditambahkan ke ViewModel.
                  if (result is Map<String, dynamic>) {
                    await runVM.addRun(RunModel.fromMap(result));
                  } else if (result is RunModel) {
                    await runVM.addRun(result);
                  }
                }
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add),
            )
          : null,

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