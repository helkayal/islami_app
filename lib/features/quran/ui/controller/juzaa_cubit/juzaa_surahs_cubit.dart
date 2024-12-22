import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/features/quran/data/models/quran_model.dart';
import 'package:islami_app/features/quran/data/repos/quran_repo.dart';

part 'juzaa_surahs_state.dart';

class JuzaaSurahsCubit extends Cubit<JuzaaSurahsState> {
  JuzaaSurahsCubit(this.quranRepo) : super(JuzaaSurahsInitial());
  final QuranRepo quranRepo;

  Future<void> getJuzaaSurahs(int juzaaId) async {
    emit(JuzaaSurahsLoading());
    final result = await quranRepo.getJuzaaSurahs(juzaaId);
    result.fold(
      (failure) => emit(
        JuzaaSurahsError(failure.errMessage),
      ),
      (surah) => emit(
        JuzaaSurahsLoaded(surah),
      ),
    );
  }
}
