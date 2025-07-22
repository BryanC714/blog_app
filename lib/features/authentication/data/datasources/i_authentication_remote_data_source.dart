import 'package:blog_app/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class IAuthenticationRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthenticationRemoteDataSourceImplementation 
  implements IAuthenticationRemoteDataSource {
    final SupabaseClient supabaseClient;
    AuthenticationRemoteDataSourceImplementation(this.supabaseClient);
  @override
  Future<String> loginWithEmailPassword({
    required String email, 
    required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name, 
    required String email, 
    required String password}) async {
      try{
        final response = await supabaseClient.auth.signUp(
          password: password,
          email: email,
          data: {
            'name': name,
          },
        );

        if (response.user == null) {
          throw ServerException('El usuario no se puede crear, el userId es null!');
        }
        return response.user!.id;
      } catch (e) {
        throw ServerException(e.toString());
      }
  }
}