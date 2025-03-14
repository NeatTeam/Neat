import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF6C63FF);
  static const background = Color(0xFF121212);
  static const surface = Color(0xFF1E1E1E);
  static const card = Color(0xFF2C2C2C);
  static const divider = Color(0xFF323232);
  static const text = Color(0xFFFFFFFF);
  static const secondaryText = Color(0xFF9E9E9E);
  static const disabled = Color(0xFF757575);
  static const error = Color(0xFFCF6679);
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFC107);
  static const info = Color(0xFF2196F3);
}

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.card,
  dividerColor: AppColors.divider,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.text),
    bodyMedium: TextStyle(color: AppColors.text),
    titleLarge: TextStyle(color: AppColors.text),
    titleMedium: TextStyle(color: AppColors.text),
    titleSmall: TextStyle(color: AppColors.secondaryText),
  ),
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.primary.withOpacity(0.8),
    surface: AppColors.surface,
    background: AppColors.background,
    error: AppColors.error,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColors.text,
    onBackground: AppColors.text,
    onError: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.surface,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.surface,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.disabled,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.primary),
    ),
  ),
); 