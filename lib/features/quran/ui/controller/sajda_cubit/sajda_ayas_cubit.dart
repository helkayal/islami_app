import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/surah_details_model.dart';
import '../../../data/repos/quran_repo.dart';

part 'sajda_ayas_state.dart';

class SajdaAyasCubit extends Cubit<SajdaAyasState> {
  SajdaAyasCubit(this.quranRepo) : super(SajdaAyasInitial());
  final QuranRepo quranRepo;

  Future<void> getJSajdaAyas(
    int surahNumber,
  ) async {
    emit(SajdaAyasLoading());
    final result = await quranRepo.getSajdaAyasBySurah(surahNumber);
    result.fold(
      (failure) => emit(
        SajdaAyasError(failure.errMessage),
      ),
      (sajda) => emit(
        SajdaAyasLoaded(sajda),
      ),
    );
  }
}
