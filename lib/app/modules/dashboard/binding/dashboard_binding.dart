import 'package:get/get.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/patient_repository.dart';
import '../controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AppointmentRepository>()) {
      Get.lazyPut<AppointmentRepository>(() => MockAppointmentRepository());
    }
    if (!Get.isRegistered<PatientRepository>()) {
      Get.lazyPut<PatientRepository>(() => MockPatientRepository());
    }
    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(() => MockAuthRepository());
    }
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
