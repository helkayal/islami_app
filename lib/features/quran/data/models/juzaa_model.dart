import 'package:equatable/equatable.dart';

import 'quran_model.dart';
import 'surah_details_model.dart';

class Juzaa {
  final int number;
  final String name;
  // final List<JuzaaSurah> suras;

  Juzaa({
    required this.number,
    required this.name,
    // required this.suras,
  });

  factory Juzaa.fromJson(Map<String, dynamic> json) {
    return Juzaa(
      number: json['number'],
      name: json['name'],
      // suras: (json['suras'] as List)
      //     .map((sura) => JuzaaSurah.fromJson(sura))
      //     .toList(),
    );
  }
}

class JuzaaSurah extends Equatable {
  final QuranModel quranModel;
  final List<Ayah> ayas;

  const JuzaaSurah({
    required this.quranModel,
    required this.ayas,
  });

  @override
  List<Object?> get props => [quranModel, ayas];

  factory JuzaaSurah.fromJson(Map<String, dynamic> json) {
    return JuzaaSurah(
      quranModel: QuranModel.fromJson(json['quranModel']),
      ayas: (json['ayas'] as List).map((aya) => Ayah.fromJson(aya)).toList(),
    );
  }

  JuzaaSurah copyWith({QuranModel? quranModel, List<Ayah>? ayas}) {
    return JuzaaSurah(
      quranModel: quranModel ?? this.quranModel,
      ayas: ayas ?? this.ayas,
    );
  }
}
