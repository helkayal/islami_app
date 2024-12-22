import '../../../data/models/azkar_model.dart';

abstract class AzkarState {}

class AzkarInitial extends AzkarState {}

class AzkarLoading extends AzkarState {}

class AzkarLoaded extends AzkarState {
  final List<Azkar> azkar;
  AzkarLoaded(this.azkar);
}

class AzkarError extends AzkarState {
  final String message;
  AzkarError(this.message);
}
