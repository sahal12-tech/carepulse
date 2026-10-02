import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/loading_view.dart';
import '../controller/registration_controller.dart';

class ConsentForm extends StatelessWidget {
  const ConsentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegistrationController>();

    return Form(
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppConstants.spaceMd),
            child: Text(
              'Consent & Submission',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppConstants.spaceLg),
          _buildConsentSection(context, controller),
          const SizedBox(height: AppConstants.spaceLg),
          _buildSubmitButton(context, controller),
        ],
      ),
    );
  }

  Widget _buildConsentSection(
      BuildContext context, RegistrationController controller) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceLg),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informed Consent for Treatment',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppConstants.spaceSm),
          const Text(
            'I hereby consent to receive medical treatment and services from CarePulse Clinic. I understand that I have the right to refuse any treatment or procedure. I authorize the release of my medical information as necessary for treatment, payment, and healthcare operations.',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppConstants.spaceMd),
          Obx(() => CheckboxListTile(
                title: const Text(
                    'I have read and understood the consent form above'),
                value: controller.consentGiven.value,
                onChanged: (value) =>
                    controller.consentGiven.value = value ?? false,
                secondary: const Icon(Icons.description),
                controlAffinity: ListTileControlAffinity.leading,
              )),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(
      BuildContext context, RegistrationController controller) {
    return Obx(() => controller.isSubmitting.value
        ? const Center(
            child: LoadingView(message: 'Submitting registration...'),
          )
        : SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.submitRegistration,
              icon: const Icon(Icons.save_alt),
              label: const Text('Submit Registration'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(AppConstants.spaceLg),
              ),
            ),
          ));
  }
}