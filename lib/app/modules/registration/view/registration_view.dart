import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../routes/app_routes.dart';
import '../controller/registration_controller.dart';
import '../widgets/registration_stepper.dart';
import '../widgets/personal_info_form.dart';
import '../widgets/contact_info_form.dart';
import '../widgets/insurance_info_form.dart';
import '../widgets/medical_history_form.dart';
import '../widgets/consent_form.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Registration'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'Clear Form',
            onPressed: () => Get.find<RegistrationController>().clearForm(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.viewState.value == ViewState.loading) {
          return const LoadingView(message: 'Registering patient...');
        }

        if (controller.viewState.value == ViewState.error) {
          return ErrorStateView(
            message: controller.errorMessage.value,
            onRetry: () => {}, // Retry would just show the form again with current values
          );
        }

        if (controller.viewState.value == ViewState.success) {
          return EmptyStateView(
            icon: Icons.check_circle_outline,
            title: 'Registration Successful',
            message: 'Patient has been registered successfully.',
            actionLabel: 'Go to Patient Directory',
            onActionPressed: () => Get.toNamed(AppRoutes.patients),
          );
        }

        return const RegistrationStepper(
          steps: [
            PersonalInfoForm(),
            ContactInfoForm(),
            InsuranceInfoForm(),
            MedicalHistoryForm(),
            ConsentForm(),
          ],
          stepTitles: [
            'Personal Information',
            'Contact Information',
            'Insurance Details',
            'Medical History',
            'Consent & Submission',
          ],
        );
      }
    ),
    );
  }
}