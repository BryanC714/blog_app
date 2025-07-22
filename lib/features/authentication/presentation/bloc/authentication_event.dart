part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

final class AuthenticationSignUpEvent extends AuthenticationEvent{
  final String name;
  final String email;
  final String password;

  AuthenticationSignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

