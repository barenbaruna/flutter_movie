part of 'register_user_bloc.dart';

@immutable
abstract class RegisterUserEvent {}

class CreateAuthorsEvent extends RegisterUserEvent {
  final String? username;
  final String? email;
  final bool? isActive;
  final bool? isAuthors;
  final String? firstName;
  final String? lastName;
  final String? password1;
  final String? password2;

  CreateAuthorsEvent(
      {required this.username,
        required this.email,
        required this.isActive,
        required this.isAuthors,
        required this.firstName,
        required this.lastName,
        required this.password1,
        required this.password2});
}
