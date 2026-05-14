import 'package:flutter/material.dart';
import '../profile/edit_profile_screen.dart';
import '../../viewmodels/profile_viewmodel.dart';
import '../auth/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  final List<Map<String, dynamic>> runs;

  const ProfileScreen({super.key, required this.runs});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileViewModel vm = ProfileViewModel();

  @override
  void initState() {
    super.initState();
    vm.loadProfile().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final totalDistance = vm.getTotalDistance(widget.runs);
    final totalDuration = vm.getTotalDuration(widget.runs);

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
                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 40),
                ),

                const SizedBox(height: 12),

                Text(
                  vm.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  vm.email,
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text("Jarak", style: TextStyle(color: Colors.grey)),
                        Text("$totalDistance km"),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("Waktu", style: TextStyle(color: Colors.grey)),
                        Text("$totalDuration menit"),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("Hari", style: TextStyle(color: Colors.grey)),
                        Text("${widget.runs.length}"),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EditProfileScreen(),
                            ),
                          );

                          if (result == true) {
                            vm.loadProfile().then((_) => setState(() {}));
                          }
                        },
                        child: const Text("Edit Profile"),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () async {
                          await vm.logout();

                          if (!context.mounted) return;

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const WelcomeScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text("Logout"),
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