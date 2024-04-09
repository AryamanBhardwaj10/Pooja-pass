import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade500, // Primary for buttons, etc.
    background: Color(0xFFF4F4F4), // Background color (already set)
    secondary: Color(0xFFCFD2D9), // Secondary for accents
    tertiary: Colors.white, // Optional tertiary color
    inversePrimary: Color(0xFFE0E7FF), // Inverse of primary
  ),
);
