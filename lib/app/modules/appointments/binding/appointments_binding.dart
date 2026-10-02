import 'package:get/get.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../data/repositories/patient_repository.dart';
import '../controller/appointments_controller.dart';

class AppointmentsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AppointmentRepository>()) {
      Get.lazyPut<AppointmentRepository>(() => MockAppointmentRepository());
    }
    if (!Get.isRegistered<PatientRepository>()) {
      Get.lazyPut<PatientRepository>(() => MockPatientRepository());
    }
    Get.lazyPut<AppointmentsController>(() => AppointmentsController());
  }
}
