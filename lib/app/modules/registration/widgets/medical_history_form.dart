import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../controller/registration_controller.dart';

class MedicalHistoryForm extends StatelessWidget {
  const MedicalHistoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegistrationController>();

    return Form(
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppConstants.spaceSm),
            child: Text(
              'Medical History',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Divider(),
          _buildAllergiesSection(context, controller.allergies),
          const SizedBox(height: AppConstants.spaceMd),
          _buildMedicationsSection(context, controller.currentMedications),
        ],
      ),
    );
  }

  Widget _buildAllergiesSection(BuildContext context, RxList<String> controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Allergies',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spaceXs),
        Wrap(
          spacing: AppConstants.spaceXs,
          runSpacing: AppConstants.spaceXs,
          children: [
            _buildAllergyChip(context, 'No Known Allergies', controller, true),
            _buildAllergyChip(context, 'Peanuts', controller, false),
            _buildAllergyChip(context, 'Latex', controller, false),
            _buildAllergyChip(context, 'Shellfish', controller, false),
            _buildAllergyChip(context, 'Pollen', controller, false),
          ],
        ),
        const SizedBox(height: AppConstants.spaceSm),
        _buildCustomAllergyField(context, controller),
      ],
    );
  }

  Widget _buildAllergyChip(
      BuildContext context,
      String label,
      RxList<String> controller,
      bool isDefault) {
    final isSelected = controller.value.contains(label) ||
        (isDefault && controller.value.isEmpty);

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (label == 'No Known Allergies' && selected) {
          controller.value = ['No Known Allergies'];
        } else if (label == 'No Known Allergies' && !selected) {
          controller.value.remove('No Known Allergies');
        } else {
          final List<String> newList = List.from(controller.value);
          if (selected) {
            newList.add(label);
          } else {
            newList.remove(label);
          }
          // If they select a specific allergy, remove "No Known Allergies"
          if (label != 'No Known Allergies' && selected) {
            newList.remove('No Known Allergies');
          }
          controller.value = newList;
        }
      },
      backgroundColor: Theme.of(context).dividerColor,
      selectedColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface,
      ),
      labelPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceXs, vertical: AppConstants.spaceXs / 2),
      padding: const EdgeInsets.all(0),
    );
  }

  Widget _buildCustomAllergyField(BuildContext context, RxList<String> controller) {
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.spaceSm),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Other Allergy',
          hintText: 'Enter specific allergy',
          prefixIcon: const Icon(Icons.add_alert),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
        onFieldSubmitted: (value) {
          if (value.isNotEmpty) {
            final List<String> newList = List.from(controller.value);
            newList.remove('No Known Allergies'); // Remove default if adding specific
            newList.add(value);
            controller.value = newList;
          }
        },
      ),
    );
  }

  Widget _buildMedicationsSection(BuildContext context, RxList<String> controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Current Medications',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spaceXs),
        Wrap(
          spacing: AppConstants.spaceXs,
          runSpacing: AppConstants.spaceXs,
          children: [
            _buildMedicationChip(context, 'None', controller, true),
            _buildMedicationChip(context, 'Lisinopril', controller, false),
            _buildMedicationChip(context, 'Metformin', controller, false),
            _buildMedicationChip(context, 'Atorvastatin', controller, false),
            _buildMedicationChip(context, 'Albuterol', controller, false),
          ],
        ),
        const SizedBox(height: AppConstants.spaceSm),
        _buildCustomMedicationField(context, controller),
      ],
    );
  }

  Widget _buildMedicationChip(
      BuildContext context,
      String label,
      RxList<String> controller,
      bool isDefault) {
    final isSelected = controller.value.contains(label) ||
        (isDefault && controller.value.isEmpty);

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (label == 'None' && selected) {
          controller.value = ['None'];
        } else if (label == 'None' && !selected) {
          controller.value.remove('None');
        } else {
          final List<String> newList = List.from(controller.value);
          if (selected) {
            newList.add(label);
          } else {
            newList.remove(label);
          }
          // If they select a specific medication, remove "None"
          if (label != 'None' && selected) {
            newList.remove('None');
          }
          controller.value = newList;
        }
      },
      backgroundColor: Theme.of(context).dividerColor,
      selectedColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface,
      ),
      labelPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceXs, vertical: AppConstants.spaceXs / 2),
      padding: const EdgeInsets.all(0),
    );
  }

  Widget _buildCustomMedicationField(BuildContext context, RxList<String> controller) {
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.spaceSm),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Other Medication',
          hintText: 'Enter specific medication',
          prefixIcon: const Icon(Icons.medication),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
        onFieldSubmitted: (value) {
          if (value.isNotEmpty) {
            final List<String> newList = List.from(controller.value);
            newList.remove('None'); // Remove default if adding specific
            newList.add(value);
            controller.value = newList;
          }
        },
      ),
    );
  }
}