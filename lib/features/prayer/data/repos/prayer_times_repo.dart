import 'package:dartz/dartz.dart';

import '../../../../core/utils/error/failures.dart';
import '../models/prayer_model.dart';

abstract class PrayerTimesRepo {
  Future<Either<Failure, List<PrayerTimeModel>>> getPrayerTimes();
}
