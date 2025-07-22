import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/i_usecase.dart';
import 'package:blog_app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUpUseCaseImplementation 
  implements IUseCase<String, UserSignUpUseCaseParameters> {
    final IAuthenticationRepository authenticationRepository;
    UserSignUpUseCaseImplementation(this.authenticationRepository);

  @override
  Future<Either<Failure, String>> call(UserSignUpUseCaseParameters params) async {
    return await authenticationRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpUseCaseParameters {
  final String name;
  final String email;
  final String password;

  UserSignUpUseCaseParameters({
    required this.name,
    required this.email,
    required this.password,
  });
}