import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/run_model.dart';

class RunViewModel extends ChangeNotifier {
  // Menggunakan List bertipe RunModel, bukan Map lagi
  List<RunModel> _runs = [];
  List<RunModel> get runs => _runs;

  RunViewModel() {
    loadRuns();
  }

  // === MENGAMBIL DATA RIWAYAT LARI ===
  Future<void> loadRuns() async {
    final prefs = await SharedPreferences.getInstance();
    final String? runsString = prefs.getString('saved_runs');
    
    if (runsString != null) {
      final List<dynamic> decodedData = jsonDecode(runsString);
      
      // Mapping dari data JSON/Map mentah menjadi Objek RunModel
      _runs = decodedData
          .map((item) => RunModel.fromMap(Map<String, dynamic>.from(item)))
          .toList();
    } else {
      _runs = [];
    }
    notifyListeners();
  }

  // === MENAMBAH RIWAYAT LARI BARU ===
  Future<void> addRun(RunModel run) async {
    _runs.add(run);
    await _saveRuns();
    notifyListeners();
  }

  // === MENGHAPUS RIWAYAT LARI ===
  Future<void> deleteRun(int index) async {
    if (index >= 0 && index < _runs.length) {
      _runs.removeAt(index);
      await _saveRuns();
      notifyListeners();
    }
  }

  // === MENGEDIT RIWAYAT LARI ===
  Future<void> updateRun(int index, RunModel updatedRun) async {
    if (index >= 0 && index < _runs.length) {
      _runs[index] = updatedRun;
      await _saveRuns();
      notifyListeners();
    }
  }

  // === FUNGSI INTERNAL UNTUK MENYIMPAN KE LOCAL MEMORY ===
  Future<void> _saveRuns() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Mengubah List<RunModel> menjadi List<Map> sebelum di-encode ke JSON String
    final List<Map<String, dynamic>> mapList = _runs.map((run) => run.toMap()).toList();
    final String encodedData = jsonEncode(mapList);
    
    await prefs.setString('saved_runs', encodedData);
  }
}