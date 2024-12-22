import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import 'package:islami_app/features/azkar/data/models/azkar_model.dart';
import '../../../../core/utils/error/failures.dart';
import 'azkar_repo.dart';

class AzkarRepoImpl implements AzkarRepo {
  @override
  Future<Either<Failure, List<Azkar>>> getAzkarByCategory(
      String categoryName) async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/azkar.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      final List<AzkarCategory> categories =
          jsonData.map((data) => AzkarCategory.fromJson(data)).toList();

      final AzkarCategory category = categories.firstWhere(
        (cat) => cat.category == categoryName,
        orElse: () => throw Exception('Category not found'),
      );

      return Right(category.azkar);
    } catch (e) {
      return Left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<AzkarCategory>>> loadAzkarCategories() async {
    try {
      String data = await rootBundle.loadString("assets/data/azkar.json");
      List<dynamic> list = await json.decode(data);
      return Right(list.map((e) => AzkarCategory.fromJson(e)).toList());
    } catch (e) {
      return Left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
