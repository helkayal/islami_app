import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/api_services.dart';
import '../../../../core/utils/error/failures.dart';
import '../models/recitation.dart';
import '../models/surah_audio.dart';
import 'recitations_repo.dart';

class RecitationsRepoImpl implements RecitationsRepo {
  @override
  Future<Either<Failure, List<Recitation>>> getRecitations() async {
    try {
      Map<String, dynamic> data = await ApiServices().getAllRecitations();

      List<Recitation> recitations = [];

      for (var recitation in data['recitations']) {
        recitations.add(Recitation.fromJson(recitation));
      }

      return Right(recitations);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, SurahAudio>> fetchSurahAudio({
    required String reciterId,
    required String chapterId,
  }) async {
    try {
      final data = await ApiServices().getSurahAudio(reciterId, chapterId);

      return Right(SurahAudio.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
