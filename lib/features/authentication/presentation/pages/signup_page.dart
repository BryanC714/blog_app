import 'package:blog_app/core/theme/app_color_pallete.dart';
import 'package:blog_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blog_app/features/authentication/presentation/pages/login_page.dart';
import 'package:blog_app/features/authentication/presentation/widgets/authentication_field.dart';
import 'package:blog_app/features/authentication/presentation/widgets/authentication_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          // Aquí manejamos los estados después de enviar el evento
          if (state is AuthenticationLoadingState) {
            setState(() {
              isLoading = true;
            });
          } else if (state is AuthenticationSuccessState) {
            setState(() {
              isLoading = false;
            });
            
            // Mostrar mensaje de éxito
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('¡Usuario registrado con éxito!'),
                backgroundColor: Colors.green,
              ),
            );
            
            // Navegar al login después del registro exitoso
            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) {  // Añade esta verificación
              Navigator.of(context).pushAndRemoveUntil(
              LoginPage.route(),
              (route) => false,
          );
        }
      });
          } else if (state is AuthenticationFailureState) {
            setState(() {
              isLoading = false;
            });
            
            // Mostrar mensaje de error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error al registrar: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Crear una cuenta',
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AuthenticationField(
                    hintText: 'Nombre',
                    controller: nameController,
                  ),
                  const SizedBox(height: 15),
                  AuthenticationField(
                    hintText: 'Correo electronico',
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  AuthenticationField(
                    hintText: 'Contraseña',
                    controller: passwordController,
                    isObscureText: true,
                  ),
                  const SizedBox(height: 20),
                  isLoading 
                    ? const CircularProgressIndicator() 
                    : AuthenticationGradientButton(
                        buttonText: 'Registrarse',
                        onPressed: () {
                          // Ocultar el teclado
                          FocusScope.of(context).unfocus();
                          
                          if(formKey.currentState!.validate()) {
                            try {
                              context.read<AuthenticationBloc>().add(
                                AuthenticationSignUpEvent(
                                  name: nameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error inesperado: ${e.toString()}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        LoginPage.route(),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: '¿Tiene una cuenta?. ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Iniciar Sesion',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColorPallete.gradient2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}