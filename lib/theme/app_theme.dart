// =================================
// app_theme.dart — Calming Light Theme
// =================================
//
// PURPOSE:
// - Soothing, soft colors suitable for sensitive-content apps.
// - Clean typography, gentle contrasts, accessibility-friendly.
// - Rounded components, minimal shadows.
//
// =================================

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,

    // --------------------------
    // COLOR SYSTEM (Calm Palette)
    // --------------------------
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF9C8DD8),      // soft lavender
      secondary: const Color(0xFFB8AEEA),    // light pastel violet
      surface: const Color(0xFFF9F8FF),      // ultra-light lavender white
      surfaceTint: Colors.white,
      background: const Color(0xFFFAFAFC),   // clean neutral white
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: const Color(0xFF2D2D2D),
      onSurface: const Color(0xFF3B3B3B),
    ),

    scaffoldBackgroundColor: const Color(0xFFF7F7FB),

    // --------------------------
    // TYPOGRAPHY (Calming)
    // --------------------------
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Color(0xFF2B2B2B),
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2B2B2B),
        height: 1.3,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF363636),
        height: 1.35,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Color(0xFF444444),
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        color: Color(0xFF505050),
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        color: Color(0xFF666666),
        height: 1.45,
      ),
    ),

    // -----------------------------------
    // BUTTONS — Rounded & Friendly
    // -----------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF9C8DD8), // lavender
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF7F76C5),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // -----------------------------------
    // INPUTS — Soft Borders
    // -----------------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF3F1FF),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFDAD4F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFAA9BEB), width: 2),
      ),
      hintStyle: const TextStyle(color: Color(0xFF8A85A6)),
    ),

    // -----------------------------------
    // CARDS — Soft Surfaces
    // -----------------------------------
    cardTheme: const CardThemeData(
  color: Color(0xFFFDFCFF),
  elevation: 0,
  shadowColor: Colors.transparent,
  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
  ),
),


    // -----------------------------------
    // APP BAR — Minimal & Soft
    // -----------------------------------
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF9F8FF),
      elevation: 0,
      foregroundColor: Color(0xFF3A3A3A),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF3A3A3A),
      ),
    ),

    // -----------------------------------
    // ICONS
    // -----------------------------------
    iconTheme: const IconThemeData(
      color: Color(0xFF6B66A6),
    ),

    // -----------------------------------
    // CHIP STYLE
    // -----------------------------------
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFEDEAFF),
      selectedColor: const Color(0xFFCEC5F3),
      labelStyle: const TextStyle(
        color: Color(0xFF4A47A3),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
