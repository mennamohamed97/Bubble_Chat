part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class AuthLoginEvent extends LoginEvent {
  final String email;
  final String password;

  AuthLoginEvent({required this.email, required this.password});
}
