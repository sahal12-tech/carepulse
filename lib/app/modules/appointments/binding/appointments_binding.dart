import 'package:get/get.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../controller/appointments_controller.dart';

class AppointmentsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AppointmentRepository>()) {
      Get.lazyPut<AppointmentRepository>(() => MockAppointmentRepository());
    }
    Get.lazyPut<AppointmentsController>(() => AppointmentsController());
  }
}