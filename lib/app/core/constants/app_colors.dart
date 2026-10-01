import 'package:flutter/material.dart';

/// CarePulse Color Tokens from design-system/carepulse/MASTER.md
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF0891B2);
  static const Color onPrimary = Color(0xFF000000);
  
  static const Color secondary = Color(0xFF22D3EE);
  static const Color onSecondary = Color(0xFF0F172A);

  static const Color accent = Color(0xFF059669);
  static const Color onAccent = Color(0xFF000000);

  static const Color backgroundLight = Color(0xFFECFEFF);
  static const Color backgroundDark = Color(0xFF0F172A);

  static const Color foregroundLight = Color(0xFF164E63);
  static const Color foregroundDark = Color(0xFFF8FAFC);

  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E293B);

  static const Color cardForegroundLight = Color(0xFF164E63);
  static const Color cardForegroundDark = Color(0xFFF1F5F9);

  static const Color mutedLight = Color(0xFFE8F1F6);
  static const Color mutedDark = Color(0xFF334155);

  static const Color mutedForegroundLight = Color(0xFF475569);
  static const Color mutedForegroundDark = Color(0xFF94A3B8);

  static const Color borderLight = Color(0xFFA5F3FC);
  static const Color borderDark = Color(0xFF334155);

  static const Color destructive = Color(0xFFDC2626);
  static const Color onDestructive = Color(0xFFFFFFFF);

  static const Color ring = Color(0xFF0891B2);

  // Status colors with semantic meaning
  static const Color statusConfirmed = Color(0xFF059669);
  static const Color statusInProgress = Color(0xFF0891B2);
  static const Color statusCompleted = Color(0xFF475569);
  static const Color statusNoShow = Color(0xFFDC2626);
  static const Color statusCancelled = Color(0xFF94A3B8);
}
