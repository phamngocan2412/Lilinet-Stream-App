import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors (Indigo/Violet for Reading/Novel vibe)
  static const brandPrimary = Color(0xFF6366F1); // Indigo 500
  static const brandSecondary = Color(0xFF8B5CF6); // Violet 500
  static const brandAccent = Color(0xFFF43F5E); // Rose 500 (for likes/hearts)
  static const netflixRed = Color(0xFFE50914); // Netflix Red

  // Light Mode Palette
  static const lightBackground = Color(0xFFF8FAFC); // Slate 50
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceVariant = Color(0xFFF1F5F9); // Slate 100
  static const lightTextPrimary = Color(0xFF0F172A); // Slate 900
  static const lightTextSecondary = Color(0xFF475569); // Slate 600
  static const lightTextTertiary = Color(0xFF94A3B8); // Slate 400
  static const lightBorder = Color(0xFFE2E8F0); // Slate 200

  // Dark Mode Palette (Netflix Style)
  static const darkBackground = Color(0xFF000000); // Pure Black
  static const darkSurface = Color(0xFF121212); // Standard Dark Surface
  static const darkSurfaceVariant = Color(0xFF2B2B2B); // Lighter Grey
  static const darkTextPrimary = Color(0xFFFFFFFF); // Pure White
  static const darkTextSecondary = Color(0xFFB3B3B3); // Light Grey
  static const darkTextTertiary = Color(0xFF808080); // Darker Grey
  static const darkBorder = Color(0xFF404040); // Dark Grey Border

  // Semantic Colors
  static const error = Color(0xFFEF4444); // Red 500
  static const success = Color(0xFF22C55E); // Green 500
  static const warning = Color(0xFFEAB308); // Yellow 500
  static const info = Color(0xFF3B82F6); // Blue 500

  // Legacy/Static support (mapping to Dark mode by default for backward compat if needed)
  static const primary = brandPrimary;
  static const background = darkBackground;
  static const surface = darkSurface;
  static const surfaceVariant = darkSurfaceVariant;
  static const textPrimary = darkTextPrimary;
  static const textSecondary = darkTextSecondary;
  static const textTertiary = darkTextTertiary;

  // Gradients
  static const gradientPrimary = LinearGradient(
    colors: [brandPrimary, brandSecondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientBlackOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black87, Colors.black],
  );
}
