import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ignis/core/theme/app_colors.dart';

class AppTypography {
  static TextTheme textTheme = TextTheme(
    // Big titles
    displayLarge: GoogleFonts.poppins(
      fontSize: 56, fontWeight: FontWeight.w700, color: AppColors.black),
    displayMedium: GoogleFonts.poppins(
      fontSize: 48, fontWeight: FontWeight.w700, color: AppColors.black),
    headlineLarge: GoogleFonts.poppins(
      fontSize: 38, fontWeight: FontWeight.w600, color: AppColors.black),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 30, fontWeight: FontWeight.w600, color: AppColors.black),

    // Titles / sections
    titleLarge: GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.black),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.black),
    titleSmall: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black),

    // body
    bodyLarge: GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.black, height: 1.5),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grey, height: 1.45),
    bodySmall: GoogleFonts.inter(
      fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.grey),

    // buttons
    labelLarge: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white),
    labelMedium: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.white),
    labelSmall: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.white),
  );
}
