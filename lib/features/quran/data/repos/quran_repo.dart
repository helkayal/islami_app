import 'package:dartz/dartz.dart';

import '../../../../core/utils/error/failures.dart';
import '../models/juzaa_model.dart';
import '../models/quran_model.dart';
import '../models/surah_details_model.dart';

abstract class QuranRepo {
  Future<Either<Failure, List<QuranModel>>> getSurahs();
  Future<Either<Failure, Data>> getSurahDetails(int id);
  Future<Either<Failure, List<Juzaa>>> getJuzaas();
  Future<Either<Failure, List<QuranModel>>> getJuzaaSurahs(int juzaaId);
  Future<Either<Failure, List<Ayah>>> getSurahAyas(
      int juzaaNumber, int surahNumber, int surahId);
  Future<Either<Failure, List<QuranModel>>> getSajdaSurahs();
  Future<Either<Failure, List<Ayah>>> getSajdaAyasBySurah(int surahId);
}
