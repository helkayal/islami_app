class Recitation {
  int? id;
  String? reciterName;
  String? style;
  String? translatedName;
  String? audioUrl;
  String? image;
  Recitation({
    this.id,
    this.reciterName,
    this.style,
    this.translatedName,
    this.audioUrl,
    this.image,
  });

  factory Recitation.fromJson(Map<String, dynamic> json) {
    return Recitation(
      audioUrl: json['audio_url']?.toString(),
      id: json['id'],
      reciterName: json['reciter_name'],
      style: json['style'],
      translatedName: json['translated_name'] != null
          ? json['translated_name']['name']
          : null,
    );
  }

  static const Map<String, String> styleTranslations = {
    'Murattal': 'مرتل',
    'Muallim': 'موليم',
    'Mujawwad': 'مجود',
  };
}
