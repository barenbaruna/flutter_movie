import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/core/api_client.dart';
import 'package:flutter_movie/response/film_response.dart';

class FilmRepository extends ApiClient {
  Future<FilmResponse> getAllFilm() async {
    try {
      final response = await dio.get('film');
      debugPrint('Hasil response: ${response.data['data']}');
      return FilmResponse.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw e.toString();
    }
  }
}
