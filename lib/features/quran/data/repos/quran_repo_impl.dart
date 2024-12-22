import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'package:islami_app/core/utils/error/failures.dart';

import 'package:islami_app/features/quran/data/models/quran_model.dart';
import 'package:islami_app/features/quran/data/models/surah_details_model.dart';

import '../../../../core/utils/api_services.dart';
import '../models/juzaa_model.dart';
import 'quran_repo.dart';

class QuranRepoImpl implements QuranRepo {
  @override
  Future<Either<Failure, List<QuranModel>>> getSurahs() async {
    try {
      String data = await rootBundle.loadString("assets/data/surahs.json");
      List<dynamic> list = await json.decode(data);
      return Right(list.map((e) => QuranModel.fromJson(e)).toList());
    } catch (e) {
      return Left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Data>> getSurahDetails(int id) async {
    try {
      var data = await ApiServices().getSurahDetails(id);
      return Right(Data.fromJson(data['data']));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Juzaa>>> getJuzaas() async {
    try {
      String data = await rootBundle.loadString("assets/data/juzaa.json");
      List<dynamic> list = await json.decode(data);
      return Right(list.map((e) => Juzaa.fromJson(e)).toList());
    } catch (e) {
      return Left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<QuranModel>>> getJuzaaSurahs(int juzaaId) async {
    try {
      var data = await ApiServices().getJuzaaData(juzaaId);
      var surahList = (data['data']['surahs'] as Map<String, dynamic>)
          .values
          .map((surahJson) => QuranModel.fromJson(surahJson))
          .toList();
      return Right(surahList);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Ayah>>> getSurahAyas(
      int juzaaNumber, int surahNumber, int surahId) async {
    try {
      var data =
          await ApiServices().getSurahAyas(juzaaNumber, surahNumber, surahId);
      List<dynamic> list = data["data"]["ayahs"];
      List<Ayah> ayahs = list.map((item) => Ayah.fromJson(item)).toList();
      return Right(ayahs);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<QuranModel>>> getSajdaSurahs() async {
    try {
      var data = await ApiServices().getSajdas();
      var ayahs = (data['data']['ayahs'] as List<dynamic>);

      var surahMap = <int, QuranModel>{};
      for (var ayaJson in ayahs) {
        var surahJson = ayaJson['surah'];
        var surah = QuranModel.fromJson(surahJson);
        surahMap[surah.number!] = surah;
      }

      var surahList = surahMap.values.toList();
      return Right(surahList);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Ayah>>> getSajdaAyasBySurah(
      int surahNumber) async {
    try {
      var data = await ApiServices().getSajdas();
      var ayahs = (data['data']['ayahs'] as List<dynamic>);

      var filteredAyahs = ayahs
          .where((ayaJson) => ayaJson['surah']['number'] == surahNumber)
          .map((ayaJson) => Ayah.fromJson(ayaJson))
          .toList();

      return Right(filteredAyahs);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
