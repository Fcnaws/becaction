import 'package:flutter/material.dart';
import 'package:ignis/core/theme/app_colors.dart';
import 'package:ignis/core/theme/app_typography.dart';

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
    );

    return base.copyWith(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      textTheme: AppTypography.textTheme,

      // APP BAR
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.silver, // #F5F7FA
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        shadowColor: Color.fromRGBO(0, 0, 0, 0.25),
        foregroundColor: AppColors.black,
        toolbarHeight: 80,
      ),

      // BOTTUN ELEVATED (full)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // verde #28CB88
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),

      // BOTTUN TEXT (text simple)
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary, // usa cor principal (verde)
          textStyle: AppTypography.textTheme.titleSmall,
        ),
      ),

      // BOTTUNS OUTLINED (border)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          textStyle: AppTypography.textTheme.titleSmall,
        ),
      ),

      // ÍCONS / divisions / CARDS
      iconTheme: const IconThemeData(color: AppColors.secondary),
      dividerColor: AppColors.greyBlue,
      cardTheme: CardThemeData(
        color: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // 🔹 INPUTS / CAMPOS DE TEXTO
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.silver, // fundo dos inputs (#F5F7FA)
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.silver),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.silver),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: AppTypography.textTheme.bodyMedium,
      ),
    );
  }
}
