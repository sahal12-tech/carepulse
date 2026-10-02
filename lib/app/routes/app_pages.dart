import 'package:get/get.dart';
import '../modules/appointments/binding/appointments_binding.dart';
import '../modules/appointments/view/appointments_view.dart';
import '../modules/auth/binding/auth_binding.dart';
import '../modules/auth/view/login_view.dart';
import '../modules/dashboard/binding/dashboard_binding.dart';
import '../modules/dashboard/view/dashboard_view.dart';
import '../modules/patient_profile/binding/patient_profile_binding.dart';
import '../modules/patient_profile/view/patient_profile_view.dart';
import '../modules/patients/binding/patients_binding.dart';
import '../modules/patients/view/patient_directory_view.dart';
import '../modules/registration/binding/registration_binding.dart';
import '../modules/registration/view/registration_view.dart';
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
      page: () => const PatientDirectoryView(),
      binding: PatientsBinding(),
    ),
    GetPage(
      name: AppRoutes.patientProfile,
      page: () => const PatientProfileView(),
      binding: PatientProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.appointments,
      page: () => const AppointmentsView(),
      binding: AppointmentsBinding(),
    ),
    GetPage(
      name: AppRoutes.registration,
      page: () => const RegistrationView(),
      binding: RegistrationBinding(),
    ),
  ];
}
