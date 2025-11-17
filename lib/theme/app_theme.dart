// =================================
// app_theme.dart — Integration Guide
// =================================
// PURPOSE:
// - Centralized theme styles for the entire app.
// - Defines typography, colors, and Material component styling.
//
// YOU WILL MODIFY THIS FILE WHEN:
// - Updating brand colors / typography.
// - Adding dark mode or theme switching.
// - Styling buttons, text fields, cards, etc.
//
// KEEP THIS FILE UI-AGNOSTIC.
// =================================

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    primarySwatch: Colors.purple, // brand color (can customize later)
    scaffoldBackgroundColor: Colors.white,

    // Base typography for the app
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(fontSize: 16),
    ),

    // You can add:
    // elevatedButtonTheme, inputDecorationTheme, iconTheme, etc.
  );
}
