import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get darkTheme => lightTheme;

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.brandBlack,
      colorScheme: const ColorScheme.light(
        primary: AppColors.brandBlack,
        secondary: AppColors.neonLime,
        surface: AppColors.surface,
        onPrimary: AppColors.textWhite,
        onSurface: AppColors.textPrimary,
      ),
      fontFamily: 'Cairo',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          fontFamily: 'Cairo',
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.surfaceBorder, width: 1.2),
        ),
      ),
    );
  }
}
