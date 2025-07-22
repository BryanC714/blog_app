import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/authentication/data/datasources/i_authentication_remote_data_source.dart';
import 'package:blog_app/features/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:blog_app/features/authentication/domain/usecases/user_sign_up_usecase_implementation.dart';
import 'package:blog_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blog_app/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(
            useCaseImplementation: UserSignUpUseCaseImplementation(
              AuthenticationRepositoryImplementation(
                AuthenticationRemoteDataSourceImplementation(
                  supabase.client,
                ),
              ),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}


