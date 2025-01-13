import 'package:equatable/equatable.dart';

import '../../data/models/prayer_model.dart';

abstract class PrayerTimesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PrayerTimesInitial extends PrayerTimesState {}

class PrayerTimesLoading extends PrayerTimesState {}

class PrayerTimesLoaded extends PrayerTimesState {
  final List<PrayerTimeModel> prayers;
  final String city;
  final String country;
  final String hijriDate;
  final String gregorianDate;

  PrayerTimesLoaded({
    required this.prayers,
    required this.city,
    required this.country,
    required this.hijriDate,
    required this.gregorianDate,
  });

  @override
  List<Object?> get props => [prayers, city, country, hijriDate, gregorianDate];
}

class PrayerTimesError extends PrayerTimesState {
  final String message;
  PrayerTimesError(this.message);

  @override
  List<Object?> get props => [message];
}
