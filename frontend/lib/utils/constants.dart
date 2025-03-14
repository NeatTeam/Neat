import 'package:flutter/material.dart';

// App theme colors
class AppColors {
  static const Color primary = Color(0xFF4CAF50);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color background = Color(0xFF121212);
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color darkGrey = Color(0xFF2A2A2A);
  static const Color grey = Color(0xFF757575);
  static const Color card = Color(0xFF262626);
  static const Color error = Color(0xFFCF6679);
  static const Color success = Color(0xFF4CAF50);
  static const Color divider = Color(0xFF424242);
  static const Color shadow = Color(0x80000000); // black with 50% opacity
  static const Color white = Colors.white;
  static const Color secondaryText = Color(0xFF9E9E9E);
}

// App text styles
class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headline1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headline2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headline3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subtitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle subtitle2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
  );
  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );
  static const TextStyle price = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
}

// App theme data
class AppTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.primary,
      surface: AppColors.surface,
      background: AppColors.background,
      error: AppColors.error,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
      fontFamily: 'Roboto',
    ),
    cardTheme: CardTheme(
      color: AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 0.5,
      space: 24,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 24.0,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1A1A1A),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    ),
  );
}

// App constants
class AppConstants {
  static const String appName = 'Neat Cleaning';
  static const String appVersion = '1.0.0';
  static const String defaultAddress = '123 Main St, Anytown, USA';
} 