import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/recitations_repo.dart';
import 'recitation_state.dart';

class RecitationCubit extends Cubit<RecitationState> {
  RecitationCubit(this._recitationRepo) : super(RecitationInitial());
  final RecitationsRepo _recitationRepo;

  Future<void> getRecitations() async {
    emit(RecitationLoading());
    final result = await _recitationRepo.getRecitations();
    result.fold(
      (failure) => emit(
        RecitationFailure(failure.errMessage),
      ),
      (recitations) => emit(
        RecitationSuccess(recitations),
      ),
    );
  }
}
