part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class AuthSignupEvent extends SignupEvent {
  final String email;
  final String password;

  AuthSignupEvent({required this.email, required this.password});
}
