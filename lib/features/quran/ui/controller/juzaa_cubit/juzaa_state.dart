part of 'juzaa_cubit.dart';

sealed class JuzaaState extends Equatable {
  const JuzaaState();

  @override
  List<Object> get props => [];
}

final class JuzaaInitial extends JuzaaState {}

final class JuzaaLoading extends JuzaaState {}

final class JuzaaLoaded extends JuzaaState {
  final List<Juzaa> juzaa;
  const JuzaaLoaded(this.juzaa);

  @override
  List<Object> get props => [juzaa];
}

final class JuzaaError extends JuzaaState {
  final String errMessage;
  const JuzaaError(this.errMessage);
}
