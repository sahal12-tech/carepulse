import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class LightTheme {
  LightTheme._();

  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        tertiary: AppColors.accent,
        onTertiary: AppColors.onAccent,
        surface: AppColors.backgroundLight,
        onSurface: AppColors.foregroundLight,
        surfaceContainerLow: AppColors.cardLight,
        error: AppColors.destructive,
        onError: AppColors.onDestructive,
        outline: AppColors.borderLight,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      fontFamily: AppConstants.fontFamily,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.w800,
          height: 1.2,
          color: AppColors.foregroundLight,
        ),
        displayMedium: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          height: 1.3,
          color: AppColors.foregroundLight,
        ),
        displaySmall: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          height: 1.4,
          color: AppColors.foregroundLight,
        ),
        headlineLarge: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          height: 1.5,
          color: AppColors.foregroundLight,
        ),
        headlineMedium: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: AppColors.foregroundLight,
        ),
        headlineSmall: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: AppColors.foregroundLight,
        ),
        titleLarge: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          height: 1.5,
          color: AppColors.foregroundLight,
        ),
        titleMedium: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: AppColors.foregroundLight,
        ),
        titleSmall: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: AppColors.foregroundLight,
        ),
        bodyLarge: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: AppColors.foregroundLight,
        ),
        bodyMedium: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: AppColors.foregroundLight,
        ),
        bodySmall: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: AppColors.mutedForegroundLight,
        ),
        labelLarge: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: AppColors.foregroundLight,
        ),
        labelMedium: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.5,
          color: AppColors.mutedForegroundLight,
        ),
        labelSmall: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.5,
          color: AppColors.mutedForegroundLight,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onAccent,
          minimumSize: const Size(0, AppConstants.minTouchTarget),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceLg,
            vertical: AppConstants.spaceSm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          textStyle: const TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.foregroundLight,
          minimumSize: const Size(0, AppConstants.minTouchTarget),
          side: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceLg,
            vertical: AppConstants.spaceSm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          textStyle: const TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(0, AppConstants.minTouchTarget),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceLg,
            vertical: AppConstants.spaceSm,
          ),
          textStyle: const TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceMd,
          vertical: AppConstants.spaceSm + 4,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.destructive,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.destructive,
            width: 2,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardLight,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          side: const BorderSide(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.onPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.mutedLight;
        }),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderLight,
        thickness: 1,
        space: AppConstants.spaceMd,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cardLight,
        foregroundColor: AppColors.foregroundLight,
        elevation: 1,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.foregroundLight,
        ),
      ),
    );
  }
}
