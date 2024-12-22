class SurahAudio {
  int? id;
  String? audioUrl;

  SurahAudio({
    this.id,
    this.audioUrl,
  });

  factory SurahAudio.fromJson(Map<String, dynamic> json) {
    return SurahAudio(
      id: json['audio_file']['id'],
      audioUrl: json['audio_file']['audio_url']?.toString(),
    );
  }
}
