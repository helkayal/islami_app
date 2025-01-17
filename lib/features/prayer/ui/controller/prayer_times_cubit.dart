import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/error/failures.dart';
import '../../data/models/prayer_model.dart';
import '../../data/repos/prayer_times_repo.dart';
import 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final PrayerTimesRepo prayerTimesRepo;

  PrayerTimesCubit({required this.prayerTimesRepo})
      : super(PrayerTimesInitial());

  Future<void> loadPrayerTimes() async {
    emit(PrayerTimesLoading());

    // 1) Call the repo, which returns Either<Failure, List<PrayerTimeModel>>
    final Either<Failure, List<PrayerTimeModel>> result =
        await prayerTimesRepo.getPrayerTimes();

    // 2) Fold over the result
    result.fold(
      (failure) {
        // Left -> Failure
        emit(PrayerTimesError(failure.errMessage));
      },
      (prayersList) async {
        // Right -> we got a List<PrayerTimeModel>
        try {
          // 2.a) Also get position for reverse geocoding (if not done in repo)
          final position = await Geolocator.getCurrentPosition();

          // 2.b) Reverse geocoding to get city/country
          final placemarks = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );

          String cityName = '';
          String countryName = '';
          if (placemarks.isNotEmpty) {
            cityName = placemarks[0].locality ?? '';
            countryName = placemarks[0].country ?? '';
          }

          // 2.c) Hijri date with hijri package
          final hijriCalendar = HijriCalendar.now();
          // Adjust by +/- 1 if needed: hijriCalendar.hijriAdjust = 1;
          HijriCalendar.setLocal("ar");
          final hijriDateString = hijriCalendar.toFormat("dd MM yyyy");

          // 2.d) Gregorian date with intl
          final now = DateTime.now();
          final gregorianDateString =
              DateFormat.yMMMMd('ar').format(now).toString();
          // DateFormat('dd-MMMM-yyyy').format(now);

          // 2.e) Finally emit loaded state
          emit(PrayerTimesLoaded(
            prayers: prayersList,
            city: cityName,
            country: countryName,
            hijriDate: hijriDateString,
            gregorianDate: gregorianDateString,
          ));
        } catch (e) {
          // If we fail in reverse geocoding or other steps
          emit(PrayerTimesError(e.toString()));
        }
      },
    );
  }
}



// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../data/repos/prayer_times_repo.dart';
// import 'prayer_times_state.dart';

// class PrayerTimesCubit extends Cubit<PrayerTimesState> {
//   final PrayerTimesRepo prayerTimesRepo;

//   PrayerTimesCubit({required this.prayerTimesRepo})
//       : super(PrayerTimesInitial());

//   Future<void> loadPrayerTimes() async {
//     emit(PrayerTimesLoading());
//     try {
//       final result = await prayerTimesRepo.getPrayerTimes();
//       result.fold(
//         (failure) => emit(PrayerTimesError(failure.errMessage)),
//         (times) => emit(PrayerTimesLoaded(times)),
//       );
//     } catch (e) {
//       emit(PrayerTimesError(e.toString()));
//     }
//   }
// }
