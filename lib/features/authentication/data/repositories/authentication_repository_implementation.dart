import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/features/authentication/data/datasources/i_authentication_remote_data_source.dart';
import 'package:blog_app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthenticationRepositoryImplementation
    implements IAuthenticationRepository {
  final IAuthenticationRemoteDataSource authenticationRemoteDataSource;
  
  const AuthenticationRepositoryImplementation(this.authenticationRemoteDataSource);
  
  @override
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await authenticationRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      
      return right(userId);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}