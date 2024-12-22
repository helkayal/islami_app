part of 'juzaa_surahs_cubit.dart';

sealed class JuzaaSurahsState extends Equatable {
  const JuzaaSurahsState();

  @override
  List<Object> get props => [];
}

final class JuzaaSurahsInitial extends JuzaaSurahsState {}

final class JuzaaSurahsLoading extends JuzaaSurahsState {}

final class JuzaaSurahsLoaded extends JuzaaSurahsState {
  final List<QuranModel> surahs;
  const JuzaaSurahsLoaded(this.surahs);

  @override
  List<Object> get props => [surahs];
}

final class JuzaaSurahsError extends JuzaaSurahsState {
  final String errMessage;
  const JuzaaSurahsError(this.errMessage);
}
