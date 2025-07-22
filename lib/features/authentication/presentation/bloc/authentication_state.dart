part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {
  const AuthenticationState();
}

final class AuthenticationInitialState extends AuthenticationState {}

final class AuthenticationLoadingState extends AuthenticationState {}

final class AuthenticationSuccessState extends AuthenticationState {
  final String userId;
  const AuthenticationSuccessState(this.userId);
}

final class AuthenticationFailureState extends AuthenticationState {
  final String message;
  const AuthenticationFailureState(this.message);
}
