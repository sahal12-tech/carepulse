import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../controller/registration_controller.dart';

class InsuranceInfoForm extends StatelessWidget {
  const InsuranceInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegistrationController>();

    return Form(
      child: ListView(
        children: [
          _buildDropdownField(
            context,
            controller.insuranceProvider,
            'Insurance Provider',
            'Select provider',
            [
              'BlueCross BlueShield',
              'UnitedHealthcare',
              'Aetna',
              'Cigna',
              'Humana',
              'Kaiser Permanente',
            ],
          ),
          const SizedBox(height: AppConstants.spaceSm),
          _buildTextField(
            context,
            controller.insuranceNumberTextController,
            'Insurance Number',
            'Enter insurance number',
            Icons.health_and_safety,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      BuildContext context,
      TextEditingController textController,
      String label,
      String hint,
      IconData icon,
      ) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      validator: (value) =>
      value == null || value.isEmpty ? '$label is required' : null,
    );
  }

  Widget _buildDropdownField(
      BuildContext context,
      RxString controller,
      String label,
      String hint,
      List<String> items,
      ) {
    return Obx(() => DropdownButtonFormField<String>(
      initialValue: controller.value.isEmpty ? null : controller.value,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      ))
          .toList(),
      onChanged: (value) => controller.value = value ?? '',
      validator: (value) =>
      value == null || value.isEmpty ? '$label is required' : null,
    ));
  }
}