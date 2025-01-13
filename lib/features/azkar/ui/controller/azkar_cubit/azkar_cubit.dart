import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/azkar_repo.dart';
import 'azkar_states.dart';

class AzkarCubit extends Cubit<AzkarState> {
  final AzkarRepo azkarRepo;
  AzkarCubit(this.azkarRepo) : super(AzkarInitial());

  Future<void> loadAzkarForCategory(String category) async {
    emit(AzkarLoading());
    final result = await azkarRepo.getAzkarByCategory(category);
    result.fold(
      (failure) => emit(
        AzkarError(failure.errMessage),
      ),
      (azkar) => emit(
        AzkarLoaded(azkar),
      ),
    );
  }
}
