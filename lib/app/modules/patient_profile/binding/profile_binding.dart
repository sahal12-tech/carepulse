import 'package:get/get.dart';
import '../../../data/repositories/patient_repository.dart';
import '../controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<PatientRepository>()) {
      Get.lazyPut<PatientRepository>(() => MockPatientRepository());
    }
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}