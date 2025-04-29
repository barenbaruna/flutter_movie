import 'package:flutter_movie/models/film_model.dart';

class FilmResponse {
  List<FilmModel> listFilmModel = [];

  FilmResponse.fromJson(json) {
    for (int i = 0; i < json.length; i++) {
      FilmModel filmModel = FilmModel.fromJson(json[i]);
      listFilmModel.add(filmModel);
    }
  }
}
