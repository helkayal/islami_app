import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/features/quran/data/models/surah_details_model.dart';
import 'package:islami_app/features/quran/data/repos/quran_repo.dart';

part 'surah_details_state.dart';

class SurahDetailsCubit extends Cubit<SurahDetailsState> {
  SurahDetailsCubit(this.quranRepo) : super(SurahDetailsInitial());
  final QuranRepo quranRepo;
  Future<void> getSurahDetails(int id) async {
    emit(SurahDetailsLoading());
    final result = await quranRepo.getSurahDetails(id);
    result.fold(
      (failure) => emit(
        SurahDetailsError(failure.errMessage),
      ),
      (surah) => emit(
        SurahDetailsLoaded(surah),
      ),
    );
  }
}
