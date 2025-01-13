import 'package:adhan_dart/adhan_dart.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/utils/error/failures.dart';
import '../models/prayer_model.dart';
import 'prayer_times_repo.dart';

class PrayerTimesRepoImpl implements PrayerTimesRepo {
  @override
  Future<Either<Failure, List<PrayerTimeModel>>> getPrayerTimes() async {
    try {
      // 1) Get user location
      final position = await Geolocator.getCurrentPosition();

      // 2) Create Coordinates (Adhan)
      final coordinates = Coordinates(position.latitude, position.longitude);

      // 3) Choose your Calculation Method & create a PrayerTimes object
      final params = CalculationMethod.egyptian();
      params.madhab = Madhab.shafi;
      final now = DateTime.now().toLocal();
      final prayerTimes = PrayerTimes(
          date: now, coordinates: coordinates, calculationParameters: params);

      // 4) Convert prayer times to List<String>
      final timesList = <PrayerTimeModel>[
        PrayerTimeModel(name: 'Fajr', dateTime: prayerTimes.fajr!.toLocal()),
        PrayerTimeModel(
            name: 'Sunrise', dateTime: prayerTimes.sunrise!.toLocal()),
        PrayerTimeModel(name: 'Dhuhr', dateTime: prayerTimes.dhuhr!.toLocal()),
        PrayerTimeModel(name: 'Asr', dateTime: prayerTimes.asr!.toLocal()),
        PrayerTimeModel(
            name: 'Maghrib', dateTime: prayerTimes.maghrib!.toLocal()),
        PrayerTimeModel(name: 'Isha', dateTime: prayerTimes.isha!.toLocal()),
      ];

      return Right(timesList);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Helper to format a `DateTime` to hh:mm (24-hour) or 12-hour format
  // String _formatDateTime(DateTime? dateTime) {
  //   if (dateTime == null) {
  //     // Return a fallback or placeholder
  //     return '--:--';
  //   }
  //   final hour = dateTime.hour.toString().padLeft(2, '0');
  //   final minute = dateTime.minute.toString().padLeft(2, '0');
  //   return '$hour:$minute';
  // }
}
