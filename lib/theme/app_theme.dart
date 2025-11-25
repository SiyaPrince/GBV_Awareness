// =================================
// app_theme.dart — GBV Awareness Theme (Updated for Flutter 3.22+)
// =================================
//
// HOW TO USE:
// 1. Import into main.dart:
//      import 'package:your_app/theme/app_theme.dart';
//
// 2. Set as app theme:
//      theme: AppTheme.light,
//
// 3. This theme uses the new M3 surface container system.
//    No deprecated fields such as background/onBackground/surfaceVariant.
//
// =================================

import 'package:flutter/material.dart';

class AppTheme {
  static const _primary = Color(0xFF4A148C); // Deep Purple
  static const _secondary = Color(0xFFD8C9FF); // Soft Lavender
  static const _accent = Color(0xFFC2185B); // Deep Rose (CTA)
  static const _bg = Color(0xFFF5EDE0); // Light Sand
  static const _surface = Color(0xFFFAF8FC); // Near-white lavender
  static const _dark = Color(0xFF1C1F26); // Charcoal/Navy

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // --------------------------
    // COLOR SYSTEM (M3-compliant)
    // --------------------------
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _primary,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF6A1B9A),
      onPrimaryContainer: Colors.white,

      secondary: _secondary,
      onSecondary: _dark,
      secondaryContainer: Color(0xFFEDE3FF),
      onSecondaryContainer: _dark,

      surface: _surface,
      onSurface: Color(0xFF2D2D2D),

      // New M3 fields replacing old background/surfaceVariant
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF8F4FA),
      surfaceContainer: Color(0xFFF3ECF9),
      surfaceContainerHigh: Color(0xFFE9E1F3),
      surfaceContainerHighest: Color(0xFFE1D9ED),

      outline: Color(0xFFB9AEE6),
      outlineVariant: Color(0xFFE4DCF8),

      error: Colors.red,
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD4),
      onErrorContainer: Color(0xFF410002),

      tertiary: _accent,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFF6C1D3),
      onTertiaryContainer: Color(0xFF3B0015),
    ),

    scaffoldBackgroundColor: _bg,

    // --------------------------
    // TYPOGRAPHY (Montserat & Open Sans)
    // --------------------------
    fontFamily: "OpenSans",
    textTheme: const TextTheme(
      // Headings use Montserrat
      headlineLarge: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 34,
        fontWeight: FontWeight.w700,
        height: 1.35,
        color: _dark,
      ),
      headlineMedium: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.35,
        color: _dark,
      ),
      headlineSmall: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.35,
        color: _dark,
      ),

      // Body text uses Open Sans
      bodyLarge: TextStyle(fontSize: 16, height: 1.6, color: Color(0xFF3B3B3B)),
      bodyMedium: TextStyle(
        fontSize: 15,
        height: 1.55,
        color: Color(0xFF505050),
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        height: 1.50,
        color: Color(0xFF666666),
      ),
    ),

    // --------------------------
    // APP BAR
    // --------------------------
    appBarTheme: const AppBarTheme(
      backgroundColor: _primary,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    // --------------------------
    // BUTTONS (Deep Rose CTA)
    // --------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _accent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 1.2,
        ),
        elevation: 1,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primary,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          height: 1.2,
        ),
      ),
    ),

    // --------------------------
    // INPUT FIELDS (soft lavender borders)
    // --------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF3EBFF),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFD3C6F4)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFD3C6F4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _primary, width: 2),
      ),
      hintStyle: const TextStyle(color: Color(0xFF8D86A7)),
    ),

    // --------------------------
    // CARDS (soft surfaces)
    // --------------------------
    // cardTheme: CardTheme(
    //   color: _surface,
    //   elevation: 1,
    //   shadowColor: const Color(0x11000000),
    //   margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    // ),

    // --------------------------
    // ICONS
    // --------------------------
    iconTheme: const IconThemeData(color: _primary),

    // --------------------------
    // CHIPS
    // --------------------------
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFE0D4FF),
      selectedColor: const Color(0xFFCFBBFF),
      labelStyle: const TextStyle(fontSize: 14, color: _dark),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
