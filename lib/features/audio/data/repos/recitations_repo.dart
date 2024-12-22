import 'package:dartz/dartz.dart';

import '../../../../core/utils/error/failures.dart';
import '../models/recitation.dart';
import '../models/surah_audio.dart';

abstract class RecitationsRepo {
  Future<Either<Failure, List<Recitation>>> getRecitations();

  Future<Either<Failure, SurahAudio>> fetchSurahAudio({
    required String reciterId,
    required String chapterId,
  });
}
