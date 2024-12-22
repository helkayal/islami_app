part of 'sajda_ayas_cubit.dart';

sealed class SajdaAyasState extends Equatable {
  const SajdaAyasState();

  @override
  List<Object> get props => [];
}

final class SajdaAyasInitial extends SajdaAyasState {}

final class SajdaAyasLoading extends SajdaAyasState {}

final class SajdaAyasLoaded extends SajdaAyasState {
  final List<Ayah> ayas;
  const SajdaAyasLoaded(this.ayas);

  @override
  List<Object> get props => [ayas];
}

final class SajdaAyasError extends SajdaAyasState {
  final String errMessage;
  const SajdaAyasError(this.errMessage);
}
