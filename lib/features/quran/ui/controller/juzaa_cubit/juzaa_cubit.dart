import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/features/quran/data/repos/quran_repo.dart';

import '../../../data/models/juzaa_model.dart';

part 'juzaa_state.dart';

class JuzaaCubit extends Cubit<JuzaaState> {
  JuzaaCubit(this.quranRepo) : super(JuzaaInitial());
  final QuranRepo quranRepo;

  Future<void> getJuzaas() async {
    emit(JuzaaLoading());
    final result = await quranRepo.getJuzaas();
    result.fold(
      (failure) => emit(
        JuzaaError(failure.errMessage),
      ),
      (juzaa) => emit(
        JuzaaLoaded(juzaa),
      ),
    );
  }
}
