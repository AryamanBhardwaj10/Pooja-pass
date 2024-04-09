import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFF3347B8), // Darker blue for primary
    background: Colors.grey.shade900, // Dark background
    secondary: const Color(0xFF4A4A4A), // Even darker gray for accents
    tertiary: const Color(0xFF555555), // Darker tertiary for some elements
    inversePrimary: const Color(0xFF9AAFFF), // Lighter blue for inverse
  ),
);
