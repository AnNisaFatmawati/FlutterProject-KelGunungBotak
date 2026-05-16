class RunModel {
  final String id;
  final double distance;
  final String duration;
  final String date;

  RunModel({
    required this.id,
    required this.distance,
    required this.duration,
    required this.date,
  });

  // Mengubah Map (dari SharedPreferences) menjadi Objek RunModel
  factory RunModel.fromMap(Map<String, dynamic> map) {
    return RunModel(
      id: map['id'] ?? '',
      distance: (map['distance'] ?? 0.0).toDouble(),
      duration: map['duration'] ?? '',
      date: map['date'] ?? '',
    );
  }

  // Mengubah Objek RunModel menjadi Map (untuk disimpan ke SharedPreferences)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'distance': distance,
      'duration': duration,
      'date': date,
    };
  }
}