import 'package:flutter/material.dart';
import 'color_palette.dart';

class AppStyle {
  // Apple-like, modern, clean text styles
  static const TextStyle headline = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -1.2,
    fontFamily: 'SF Pro Display',
  );

  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'SF Pro Display',
  );

  static const TextStyle body = TextStyle(
    fontSize: 18,
    color: AppColors.textPrimary,
    fontFamily: 'SF Pro Text',
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
    fontFamily: 'SF Pro Text',
  );

  static ButtonStyle elevatedButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'SF Pro Text',
    ),
    elevation: 0,
    shadowColor: Colors.transparent,
  );

  static CardThemeData cardTheme = const CardThemeData(
    color: AppColors.card,
    elevation: 0,
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(18)),
    ),
  );

  // ThemeData for different age groups (future extensibility)
  static ThemeData themeForAge(int age) {
    // For now, return a modern, clean theme for all ages
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: const TextTheme(
        displayLarge: headline,
        titleLarge: title,
        bodyLarge: body,
        bodyMedium: body,
        titleMedium: subtitle,
      ),
      cardTheme: cardTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButton),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        titleTextStyle: headline,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        filled: true,
        fillColor: AppColors.card,
      ),
    );
  }
} 