import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:islami_app/features/azkar/data/repos/azkar_repo.dart';
import 'azkar_categories_states.dart';

class AzkarCategoriesCubit extends Cubit<AzkarCategoriesState> {
  final AzkarRepo azkarRepo;
  AzkarCategoriesCubit(this.azkarRepo) : super(AzkarCategoriesInitial());

  Future<void> loadAzkarCategories() async {
    emit(AzkarCategoriesLoading());
    final result = await azkarRepo.loadAzkarCategories();
    result.fold(
      (failure) => emit(
        AzkarCategoriesError(failure.errMessage),
      ),
      (azkarCategories) => emit(
        AzkarCategoriesLoaded(azkarCategories),
      ),
    );
  }
}
