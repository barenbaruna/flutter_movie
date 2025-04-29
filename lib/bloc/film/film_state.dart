part of 'film_bloc.dart';

@immutable
abstract class FilmState {}

class FilmInitial extends FilmState {}
class FilmLoading extends FilmState {}
class FilmLoaded extends FilmState {
  final List<FilmModel> listFilmModel;
  FilmLoaded({required this.listFilmModel});
}
class FilmError extends FilmState {
  final String message;
  FilmError({required this.message});
}
