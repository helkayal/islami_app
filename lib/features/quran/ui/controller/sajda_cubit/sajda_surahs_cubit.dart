import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/features/quran/data/models/quran_model.dart';
import 'package:islami_app/features/quran/data/repos/quran_repo.dart';

part 'sajda_surahs_state.dart';

class SajdaSurahsCubit extends Cubit<SajdaSurahsState> {
  SajdaSurahsCubit(this.quranRepo) : super(SajdaSurahsInitial());
  final QuranRepo quranRepo;

  Future<void> getSajdaSurahs() async {
    emit(SajdaSurahsLoading());
    final result = await quranRepo.getSajdaSurahs();
    result.fold(
      (failure) => emit(
        SajdaSurahsError(failure.errMessage),
      ),
      (surah) => emit(
        SajdaSurahsLoaded(surah),
      ),
    );
  }
}
