import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/run_viewmodel.dart';
import '../../models/run_model.dart'; 

class HomeContent extends StatelessWidget {
  final List<RunModel> runs; // Ubah tipe data dari List<Map> menjadi List<RunModel>

  const HomeContent({super.key, required this.runs});

  void _showEditDialog(BuildContext context, int index, RunModel currentRun) { // Ubah Map menjadi RunModel
    final distanceController = TextEditingController(text: currentRun.distance.toString()); // Akses objek dengan titik
    final durationController = TextEditingController(text: currentRun.duration.toString()); // Akses objek dengan titik
    final dateController = TextEditingController(text: currentRun.date.toString());         // Akses objek dengan titik

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Edit Riwayat Lari"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Tanggal",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: dialogContext,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        "${pickedDate.day.toString().padLeft(2, '0')}-"
                        "${pickedDate.month.toString().padLeft(2, '0')}-"
                        "${pickedDate.year}";

                    dateController.text = formattedDate;
                  }
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: distanceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Jarak (km)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: durationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Durasi (menit)",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            // Tombol Batal
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text("Batal"),
            ),
            // Tombol Simpan
            TextButton(
              onPressed: () async {
                // Bungkus data yang diperbarui ke dalam Objek RunModel baru
                final updatedRun = RunModel(
                  id: currentRun.id, // Pertahankan ID lama agar tidak berubah
                  distance: double.tryParse(distanceController.text) ?? currentRun.distance,
                  duration: durationController.text.isNotEmpty ? durationController.text : currentRun.duration,
                  date: dateController.text.isNotEmpty ? dateController.text : currentRun.date,
                );

                await Provider.of<RunViewModel>(context, listen: false)
                    .updateRun(index, updatedRun);

                if (!dialogContext.mounted) return;
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                "Simpan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

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
                        final run = runs[index]; // Objek RunModel

                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.directions_run),
                            title: Text("${run.distance} km"), // Gunakan properti objek .distance
                            subtitle: Text(
                              "Durasi: ${run.duration} menit\nTanggal: ${run.date}", // Gunakan properti .duration & .date
                            ),

                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Tombol Edit
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    _showEditDialog(context, index, run);
                                  },
                                ),
                                // Tombol Hapus
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Konfirmasi Hapus"),
                                          content: const Text("Apakah benar Anda ingin menghapus riwayat lari ini?"),
                                          actions: [
                                            TextButton(
                                              child: const Text("Tidak"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text(
                                                "Ya, Hapus",
                                                style: TextStyle(color: Colors.red),
                                              ),
                                              onPressed: () {
                                                Provider.of<RunViewModel>(context, listen: false)
                                                    .deleteRun(index);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
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