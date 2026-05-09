import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  final List<Map<String, dynamic>> runs;

  const HomeContent({super.key, required this.runs});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Riwayat Lari",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: runs.isEmpty
                  ? const Center(
                      child: Text(
                        "Belum ada data lari",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: runs.length,
                      itemBuilder: (context, index) {
                        final run = runs[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: const Icon(
                              Icons.directions_run,
                              color: Colors.blue,
                            ),
                            title: Text("${run['distance']} km"),
                            subtitle: Text(
                              "Durasi: ${run['duration']} menit",
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}