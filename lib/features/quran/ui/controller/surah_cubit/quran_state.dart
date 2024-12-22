part of 'quran_cubit.dart';

sealed class QuranState extends Equatable {
  const QuranState();

  @override
  List<Object> get props => [];
}

final class QuranInitial extends QuranState {}

final class QuranLoading extends QuranState {}

final class QuranLoaded extends QuranState {
  final List<QuranModel> surahs;

  const QuranLoaded(this.surahs);

  @override
  List<Object> get props => [surahs];
}

final class QuranError extends QuranState {
  final String errMessage;

  const QuranError(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
