import 'package:get/get.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../data/repositories/patient_repository.dart';
import '../controller/patient_profile_controller.dart';

class PatientProfileBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<PatientRepository>()) {
      Get.lazyPut<PatientRepository>(() => MockPatientRepository());
    }
    if (!Get.isRegistered<AppointmentRepository>()) {
      Get.lazyPut<AppointmentRepository>(() => MockAppointmentRepository());
    }
    Get.lazyPut<PatientProfileController>(() => PatientProfileController());
  }
}
