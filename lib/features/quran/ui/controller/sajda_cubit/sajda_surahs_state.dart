part of 'sajda_surahs_cubit.dart';

sealed class SajdaSurahsState extends Equatable {
  const SajdaSurahsState();

  @override
  List<Object> get props => [];
}

final class SajdaSurahsInitial extends SajdaSurahsState {}

final class SajdaSurahsLoading extends SajdaSurahsState {}

final class SajdaSurahsLoaded extends SajdaSurahsState {
  final List<QuranModel> surahs;
  const SajdaSurahsLoaded(this.surahs);

  @override
  List<Object> get props => [surahs];
}

final class SajdaSurahsError extends SajdaSurahsState {
  final String errMessage;
  const SajdaSurahsError(this.errMessage);
}
