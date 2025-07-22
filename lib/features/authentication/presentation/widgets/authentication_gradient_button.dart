import 'package:blog_app/core/theme/app_color_pallete.dart';
import 'package:flutter/material.dart';

class AuthenticationGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthenticationGradientButton({
    super.key, 
    required this.buttonText,
    required this.onPressed,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColorPallete.gradient1,
            AppColorPallete.gradient2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),

      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(395, 55),
            backgroundColor: AppColorPallete.transparentColor,
            shadowColor: AppColorPallete.transparentColor,
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 17, 
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}