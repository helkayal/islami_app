import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/features/quran/data/repos/quran_repo.dart';

import '../../../data/models/quran_model.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final QuranRepo quranRepo;
  final List<QuranModel> surahList = [];
  QuranCubit(this.quranRepo) : super(QuranInitial());
  Future<void> getSurahs() async {
    emit(QuranLoading());
    final result = await quranRepo.getSurahs();
    result.fold(
      (failure) => emit(QuranError(failure.errMessage)),
      (surah) {
        surahList.addAll(surah);
        emit(
          QuranLoaded(surah),
        );
      },
    );
  }
}
