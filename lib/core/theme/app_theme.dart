import 'package:blog_app/core/theme/app_color_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppColorPallete.borderColor]) =>
    OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 3,
    ),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColorPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(27),
    enabledBorder: _border(),
    focusedBorder: _border(AppColorPallete.gradient2),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorPallete.backgroundColor,
    ),
  );
}