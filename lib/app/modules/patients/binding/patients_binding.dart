import 'package:get/get.dart';
import '../../../data/repositories/patient_repository.dart';
import '../controller/patients_controller.dart';

class PatientsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<PatientRepository>()) {
      Get.lazyPut<PatientRepository>(() => MockPatientRepository());
    }
    Get.lazyPut<PatientsController>(() => PatientsController());
  }
}
