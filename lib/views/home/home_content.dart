import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. Import provider untuk memanggil RunViewModel
import '../../viewmodels/run_viewmodel.dart'; // 2. Import path RunViewModel kamu

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

                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Konfirmasi Hapus"),
                                content: const Text("Apakah benar Anda ingin menghapus riwayat lari ini?"),
                                actions: [
                                  // Tombol Batal
                                  TextButton(
                                    child: const Text("Tidak"),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Tutup pop-up saja
                                    },
                                  ),
                                  // Tombol Setuju Hapus
                                  TextButton(
                                    child: const Text(
                                      "Ya, Hapus",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      // Panggil fungsi deleteRun dari RunViewModel menggunakan Provider
                                      Provider.of<RunViewModel>(context, listen: false)
                                          .deleteRun(index);

                                      Navigator.of(context).pop(); // Tutup pop-up
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
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