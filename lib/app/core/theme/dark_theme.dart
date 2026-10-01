import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class DarkTheme {
  DarkTheme._();

  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.secondary,
        onPrimary: AppColors.onSecondary,
        secondary: AppColors.primary,
        onSecondary: Colors.white,
        tertiary: AppColors.accent,
        onTertiary: AppColors.onAccent,
        surface: AppColors.backgroundDark,
        onSurface: AppColors.foregroundDark,
        surfaceContainerLow: AppColors.cardDark,
        error: AppColors.destructive,
        onError: AppColors.onDestructive,
        outline: AppColors.borderDark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      fontFamily: AppConstants.fontFamily,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.w800,
          height: 1.2,
          color: AppColors.foregroundDark,
        ),
        displayMedium: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          height: 1.3,
          color: AppColors.foregroundDark,
        ),
        displaySmall: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          height: 1.4,
          color: AppColors.foregroundDark,
        ),
        headlineLarge: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          height: 1.5,
          color: AppColors.foregroundDark,
        ),
        headlineMedium: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: AppColors.foregroundDark,
        ),
        headlineSmall: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: AppColors.foregroundDark,
        ),
        titleLarge: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          height: 1.5,
          color: AppColors.foregroundDark,
        ),
        titleMedium: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: AppColors.foregroundDark,
        ),
        titleSmall: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: AppColors.foregroundDark,
        ),
        bodyLarge: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: AppColors.foregroundDark,
        ),
        bodyMedium: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: AppColors.foregroundDark,
        ),
        bodySmall: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: AppColors.mutedForegroundDark,
        ),
        labelLarge: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: AppColors.foregroundDark,
        ),
        labelMedium: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.5,
          color: AppColors.mutedForegroundDark,
        ),
        labelSmall: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.5,
          color: AppColors.mutedForegroundDark,
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
          foregroundColor: AppColors.foregroundDark,
          minimumSize: const Size(0, AppConstants.minTouchTarget),
          side: const BorderSide(
            color: AppColors.secondary,
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
          foregroundColor: AppColors.secondary,
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
        fillColor: AppColors.cardDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceMd,
          vertical: AppConstants.spaceSm + 4,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.borderDark,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.borderDark,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.secondary,
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
        color: AppColors.cardDark,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          side: const BorderSide(
            color: AppColors.borderDark,
            width: 1,
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.secondary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.onSecondary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.secondary;
          }
          return AppColors.mutedDark;
        }),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderDark,
        thickness: 1,
        space: AppConstants.spaceMd,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cardDark,
        foregroundColor: AppColors.foregroundDark,
        elevation: 1,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.foregroundDark,
        ),
      ),
    );
  }
}
