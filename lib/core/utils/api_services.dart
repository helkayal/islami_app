import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class ApiServices {
  static const String baseUrl = 'https://api.alquran.cloud/v1/';
  Future<Map<String, dynamic>> getSurahDetails(int id) async {
    var response = await Dio().get('${baseUrl}surah/$id/ar.alafasy');
    return response.data;
  }

  Future<Map<String, dynamic>> getAllRecitations() async {
    var respone = await Dio()
        .get('https://api.quran.com/api/v4/resources/recitations?language=ar');
    // print(respone.data);
    return respone.data;
  }

  Future<Map<String, dynamic>> getSurahAudio(
      String reciterId, String chapterId) async {
    var respone = await Dio().get(
        'https://api.quran.com/api/v4/chapter_recitations/$reciterId/$chapterId');
    // print(respone.data);
    return respone.data;
  }

  Future<Map<String, dynamic>> getJuzaaData(int juzaaId) async {
    var response = await Dio().get('${baseUrl}juz/$juzaaId/quran-uthmani');
    return response.data;
  }

  Future<Map<String, dynamic>> getSurahAyas(
      int juzaaNumber, int surahNumber, int surahId) async {
    String data = await rootBundle.loadString("assets/data/juzaa.json");
    List<dynamic> list = await json.decode(data);
    List<dynamic> ayaArray = list[juzaaNumber - 1]["suras"][surahId]["aya"];
    int startAya = ayaArray[0] - 1;
    int endAya = ayaArray[1];
    int limit = endAya - startAya;
    String url =
        '${baseUrl}surah/$surahNumber/ar.alafasy?offset=$startAya&limit=$limit';
    var response = await Dio().get(url);
    return response.data;
  }

  Future<Map<String, dynamic>> getSajdas() async {
    var response = await Dio().get('${baseUrl}sajda/ar.alafasy');
    return response.data;
  }

  Future<Map<String, dynamic>> getSajdaAya(ayaId) async {
    var response = await Dio().get('${baseUrl}ayah/$ayaId/ar.alafasy');
    return response.data;
  }
}
