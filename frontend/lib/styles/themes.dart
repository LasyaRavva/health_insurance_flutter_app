import 'package:flutter/material.dart';
import 'colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryBlue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.light,
    ).copyWith(secondary: AppColors.primaryGreen),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.primaryBlue),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      labelStyle: TextStyle(color: AppColors.textSecondary),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryBlue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.dark,
    ).copyWith(secondary: AppColors.primaryGreen),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}
