part of 'surah_ayas_cubit.dart';

sealed class SurahAyasState extends Equatable {
  const SurahAyasState();

  @override
  List<Object> get props => [];
}

final class SurahAyasInitial extends SurahAyasState {}

final class SurahAyasLoading extends SurahAyasState {}

final class SurahAyasLoaded extends SurahAyasState {
  final List<Ayah> ayas;
  const SurahAyasLoaded(this.ayas);

  @override
  List<Object> get props => [ayas];
}

final class SurahAyasError extends SurahAyasState {
  final String errMessage;
  const SurahAyasError(this.errMessage);
}
