import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(() => MockAuthRepository());
    }
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
