import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController(text: 'sarah.jenkins');
  final passwordController = TextEditingController(text: 'password123');

  final Rx<UserRole> selectedRole = UserRole.receptionist.obs;
  final RxBool isPasswordObscured = true.obs;
  final Rx<ViewState> viewState = ViewState.initial.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void setRole(UserRole role) {
    selectedRole.value = role;
  }

  Future<void> login() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    viewState.value = ViewState.loading;
    errorMessage.value = '';

    try {
      final success = await _authRepository.login(
        username: usernameController.text,
        password: passwordController.text,
        role: selectedRole.value,
      );

      if (success) {
        viewState.value = ViewState.success;
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        viewState.value = ViewState.error;
        errorMessage.value = 'Invalid credentials. Please try again.';
      }
    } catch (e) {
      viewState.value = ViewState.error;
      errorMessage.value = 'Failed to log in: ${e.toString()}';
    }
  }
}
