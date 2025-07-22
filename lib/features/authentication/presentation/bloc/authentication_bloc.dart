import 'package:blog_app/features/authentication/domain/usecases/user_sign_up_usecase_implementation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  // inyección de dependencias
  final UserSignUpUseCaseImplementation _useCaseImplementation;

  AuthenticationBloc({
    required UserSignUpUseCaseImplementation useCaseImplementation,
  }) : _useCaseImplementation = useCaseImplementation,
       super(AuthenticationInitialState()) {
    on<AuthenticationSignUpEvent>(
      (event, emit) async {

        final response = await _useCaseImplementation(
          UserSignUpUseCaseParameters(
            name: event.name, 
            email: event.email, 
            password: event.password
          ),
        );
        response.fold(
          (failure) => emit(AuthenticationFailureState(failure.message)), 
          (userId) => emit(AuthenticationSuccessState(userId)),
        );
      },
    );
  }
}
