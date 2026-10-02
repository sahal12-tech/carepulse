import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../controller/registration_controller.dart';

class ContactInfoForm extends StatelessWidget {
  const ContactInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegistrationController>();

    return Form(
      child: ListView(
        children: [
          _buildPhoneField(context, controller.phoneTextController),
          const SizedBox(height: AppConstants.spaceSm),
          _buildEmailField(context, controller.emailTextController),
        ],
      ),
    );
  }

  Widget _buildPhoneField(
      BuildContext context,
      TextEditingController textController,
      ) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: 'Enter phone number',
        prefixIcon: const Icon(Icons.phone),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      keyboardType: TextInputType.phone,
      validator: (value) =>
      value == null || value.isEmpty ? 'Phone number is required' : null,
    );
  }

  Widget _buildEmailField(
      BuildContext context,
      TextEditingController textController,
      ) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'Enter email address',
        prefixIcon: const Icon(Icons.email),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        // Simple email validation
        if (!value.contains('@') || !value.contains('.')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}