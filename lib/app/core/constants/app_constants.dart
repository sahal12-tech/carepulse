import 'package:flutter/material.dart';

/// Core App Constants derived from MASTER.md tokens
class AppConstants {
  AppConstants._();

  static const String appName = 'CarePulse';

  // Spacing Scale (Density 7/10 - Standard)
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;
  static const double space2xl = 48.0;
  static const double space3xl = 64.0;

  // Border Radius Scale
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;

  // Minimum Touch Target
  static const double minTouchTarget = 48.0;

  // Font Family
  static const String fontFamily = 'Atkinson Hyperlegible';
}

/// Controller ViewState enum
enum ViewState {
  initial,
  loading,
  success,
  empty,
  error,
}

/// User Roles
enum UserRole {
  receptionist,
  doctor,
  admin,
}

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.receptionist:
        return 'Receptionist';
      case UserRole.doctor:
        return 'Doctor';
      case UserRole.admin:
        return 'Admin';
    }
  }

  IconData get icon {
    switch (this) {
      case UserRole.receptionist:
        return Icons.support_agent;
      case UserRole.doctor:
        return Icons.medical_services_outlined;
      case UserRole.admin:
        return Icons.admin_panel_settings_outlined;
    }
  }
}
