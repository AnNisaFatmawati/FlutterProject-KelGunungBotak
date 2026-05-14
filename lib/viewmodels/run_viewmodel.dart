import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RunViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> _runs = [];

  List<Map<String, dynamic>> get runs => _runs;

  RunViewModel() {
    loadRuns();
  }

  Future<void> loadRuns() async {
    final prefs = await SharedPreferences.getInstance();
    final String? runsString = prefs.getString('saved_runs');

    if (runsString != null) {
      final List<dynamic> decodedData = jsonDecode(runsString);
      _runs = decodedData
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }

    notifyListeners();
  }

  Future<void> addRun(Map<String, dynamic> run) async {
    _runs.add(run);
    await _saveRuns();
    notifyListeners();
  }

  Future<void> _saveRuns() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(_runs);
    await prefs.setString('saved_runs', encodedData);
  }
}