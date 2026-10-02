import 'package:get/get.dart';
import '../../../data/repositories/patient_repository.dart';
import '../controller/registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<PatientRepository>()) {
      Get.lazyPut<PatientRepository>(() => MockPatientRepository());
    }
    Get.lazyPut<RegistrationController>(() => RegistrationController());
  }
}