import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../controller/registration_controller.dart';

class PersonalInfoForm extends StatelessWidget {
  const PersonalInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegistrationController>();

    return Form(
      child: ListView(
        children: [
          _buildTextField(
            context,
            controller.firstNameTextController,
            'First Name',
            'Enter first name',
            Icons.person_outline,
          ),
          const SizedBox(height: AppConstants.spaceSm),
          _buildTextField(
            context,
            controller.lastNameTextController,
            'Last Name',
            'Enter last name',
            Icons.person_outline,
          ),
          const SizedBox(height: AppConstants.spaceSm),
          _buildDateOfBirthField(
            context,
            controller.dateOfBirthTextController,
          ),
          const SizedBox(height: AppConstants.spaceSm),
          _buildGenderDropdown(context, controller.gender),
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

  Widget _buildDateOfBirthField(
      BuildContext context,
      TextEditingController textController,
      ) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        hintText: 'MM/DD/YYYY',
        prefixIcon: const Icon(Icons.calendar_today),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      keyboardType: TextInputType.datetime,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Date of birth is required';
        }
        // Basic format validation
        final parts = value.split('/');
        if (parts.length != 3) {
          return 'Please use MM/DD/YYYY format';
        }
        return null;
      },
    );
  }

  Widget _buildGenderDropdown(BuildContext context, RxString controller) {
    return Obx(() => DropdownButtonFormField<String>(
      value: controller.value.isEmpty ? null : controller.value,
      decoration: InputDecoration(
        labelText: 'Gender',
        prefixIcon: const Icon(Icons.transgender),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      items: ['Male', 'Female', 'Other', 'Unspecified']
          .map((gender) => DropdownMenuItem(
        value: gender,
        child: Text(gender),
      ))
          .toList(),
      onChanged: (value) => controller.value = value ?? '',
      validator: (value) =>
      value == null || value.isEmpty ? 'Gender is required' : null,
    ));
  }
}