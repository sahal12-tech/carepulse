import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/auth/binding/auth_binding.dart';
import '../modules/auth/view/login_view.dart';
import '../modules/dashboard/binding/dashboard_binding.dart';
import '../modules/dashboard/view/dashboard_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initialRoute = AppRoutes.login;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.patients,
      page: () => Scaffold(
        appBar: AppBar(title: const Text('Patient Directory')),
        body: const Center(child: Text('Patient Directory (Phase 2)')),
      ),
    ),
    GetPage(
      name: AppRoutes.patientProfile,
      page: () => Scaffold(
        appBar: AppBar(title: const Text('Patient Profile')),
        body: const Center(child: Text('Patient Profile (Phase 2)')),
      ),
    ),
    GetPage(
      name: AppRoutes.appointments,
      page: () => Scaffold(
        appBar: AppBar(title: const Text('Appointments')),
        body: const Center(child: Text('Appointments Schedule (Phase 3)')),
      ),
    ),
    GetPage(
      name: AppRoutes.registration,
      page: () => Scaffold(
        appBar: AppBar(title: const Text('Patient Registration')),
        body: const Center(child: Text('Patient Registration Stepper (Phase 3)')),
      ),
    ),
  ];
}
