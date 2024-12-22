import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/surah_audio.dart';
import '../../../data/repos/recitations_repo.dart';

part 'surah_audio_state.dart';

class SurahAudioCubit extends Cubit<SurahAudioState> {
  SurahAudioCubit(this.recitationsRep) : super(SurahAudioInitial());
  RecitationsRepo recitationsRep;
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? audioUrl;
  Future<void> fetchSurahAudio({
    required String reciterId,
    required String chapterId,
  }) async {
    emit(SurahAudioLoading());
    final result = await recitationsRep.fetchSurahAudio(
        reciterId: reciterId, chapterId: chapterId);
    result.fold((failure) {
      emit(
        SurahAudioError(failure.errMessage),
      );
    }, (surahAudios) {
      emit(
        SurahAudioLoaded(surahAudios),
      );
    });
  }
}
