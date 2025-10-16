import 'package:flutter/material.dart';

class AppColors {
  // Primary colors for health theme
  static const Color primaryBlue = Color(0xFF007BFF);
  static const Color primaryGreen = Color(0xFF28A745);
  static const Color primaryTeal = Color(0xFF20B2AA);

  // Secondary colors
  static const Color secondaryYellow = Color(0xFFFFC107);
  static const Color secondaryOrange = Color(0xFFFF9800);

  // Neutral colors
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF343A40);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);

  // Status colors
  static const Color success = Color(0xFF28A745);
  static const Color error = Color(0xFFDC3545);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF17A2B8);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
