class Azkar {
  final int id;
  final String text;
  final int count;
  final String audio;
  final String filename;

  Azkar({
    required this.id,
    required this.text,
    required this.count,
    required this.audio,
    required this.filename,
  });

  factory Azkar.fromJson(Map<String, dynamic> json) {
    return Azkar(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      count: json['count'] ?? 1,
      audio: json['audio'] ?? '',
      filename: json['filename'] ?? '',
    );
  }
}

class AzkarCategory {
  final String category;
  final List<Azkar> azkar;

  AzkarCategory({
    required this.category,
    required this.azkar,
  });

  factory AzkarCategory.fromJson(Map<String, dynamic> json) {
    return AzkarCategory(
      category: json['category'],
      azkar: List<Azkar>.from(json['azkar'].map((x) => Azkar.fromJson(x))),
    );
  }
}
