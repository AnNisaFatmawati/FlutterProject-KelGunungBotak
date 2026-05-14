import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  final List<Map<String, dynamic>> runs;

  const HomeContent({super.key, required this.runs});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                child: Text("Belum ada data lari"),
              )
                  : ListView.builder(
                itemCount: runs.length,
                itemBuilder: (context, index) {
                  final run = runs[index];

                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.directions_run),
                      title: Text("${run['distance']} km"),
                      subtitle: Text(
                        "Durasi: ${run['duration']} menit\nTanggal: ${run['date']}",
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