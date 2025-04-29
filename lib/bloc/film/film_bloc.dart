
import 'package:bloc/bloc.dart';
import 'package:flutter_movie/repo/film_repository.dart';
import 'package:flutter_movie/response/film_response.dart';
import 'package:meta/meta.dart';

import '../../models/film_model.dart';

part 'film_event.dart';
part 'film_state.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final filmRepository = FilmRepository();
  FilmBloc() : super(FilmInitial()) {
    on<FilmEvent>((event, emit) async {
      if(event is  FilmIndexEvent){
        emit(FilmLoading());
      } try {
        FilmResponse response = await filmRepository.getAllFilm();
        emit(FilmLoaded(listFilmModel: response.listFilmModel));
      } catch (e) {
        emit(FilmError(message: e.toString()));
      }
    });
  }
}
