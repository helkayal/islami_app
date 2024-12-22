import 'package:dartz/dartz.dart';

import '../../../../core/utils/error/failures.dart';
import '../models/azkar_model.dart';

abstract class AzkarRepo {
  Future<Either<Failure, List<AzkarCategory>>> loadAzkarCategories();
  Future<Either<Failure, List<Azkar>>> getAzkarByCategory(String categoryName);
}
