import '../../../data/models/azkar_model.dart';

abstract class AzkarCategoriesState {}

class AzkarCategoriesInitial extends AzkarCategoriesState {}

class AzkarCategoriesLoading extends AzkarCategoriesState {}

class AzkarCategoriesLoaded extends AzkarCategoriesState {
  final List<AzkarCategory> azkarCategories;
  AzkarCategoriesLoaded(this.azkarCategories);
}

class AzkarCategoriesError extends AzkarCategoriesState {
  final String message;
  AzkarCategoriesError(this.message);
}
