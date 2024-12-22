import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/surah_details_model.dart';
import '../../../data/repos/quran_repo.dart';

part 'surah_ayas_state.dart';

class SurahAyasCubit extends Cubit<SurahAyasState> {
  SurahAyasCubit(this.quranRepo) : super(SurahAyasInitial());
  final QuranRepo quranRepo;

  Future<void> getJSurahAyas(
      int juzaaNumber, int surahNumber, int surahId) async {
    emit(SurahAyasLoading());
    final result =
        await quranRepo.getSurahAyas(juzaaNumber, surahNumber, surahId);
    result.fold(
      (failure) => emit(
        SurahAyasError(failure.errMessage),
      ),
      (surah) => emit(
        SurahAyasLoaded(surah),
      ),
    );
  }
}
