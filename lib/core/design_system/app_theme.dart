import 'package:flutter/material.dart';
import 'package:universo_rick_v2/core/design_system/app_colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.secondary,
        surface: AppColors.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.secondary,
        elevation: 4,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: AppColors.secondary,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
