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

  Widget _buildAllergiesSection(BuildContext context, RxList<String> list) {
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
        Obx(
          () => Wrap(
            spacing: AppConstants.spaceXs,
            runSpacing: AppConstants.spaceXs,
            children: [
              _buildAllergyChip(context, 'No Known Allergies', list, true),
              _buildAllergyChip(context, 'Peanuts', list, false),
              _buildAllergyChip(context, 'Latex', list, false),
              _buildAllergyChip(context, 'Shellfish', list, false),
              _buildAllergyChip(context, 'Pollen', list, false),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spaceSm),
        _buildCustomAllergyField(context, list),
      ],
    );
  }

  Widget _buildAllergyChip(
      BuildContext context,
      String label,
      RxList<String> list,
      bool isDefault) {
    final isSelected = list.contains(label) || (isDefault && list.isEmpty);

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (label == 'No Known Allergies' && selected) {
          list.assignAll(['No Known Allergies']);
        } else if (label == 'No Known Allergies' && !selected) {
          list.remove('No Known Allergies');
        } else {
          if (selected) {
            list.remove('No Known Allergies');
            if (!list.contains(label)) list.add(label);
          } else {
            list.remove(label);
          }
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

  Widget _buildCustomAllergyField(BuildContext context, RxList<String> list) {
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
          if (value.trim().isNotEmpty) {
            list.remove('No Known Allergies');
            if (!list.contains(value.trim())) {
              list.add(value.trim());
            }
          }
        },
      ),
    );
  }

  Widget _buildMedicationsSection(BuildContext context, RxList<String> list) {
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
        Obx(
          () => Wrap(
            spacing: AppConstants.spaceXs,
            runSpacing: AppConstants.spaceXs,
            children: [
              _buildMedicationChip(context, 'None', list, true),
              _buildMedicationChip(context, 'Lisinopril', list, false),
              _buildMedicationChip(context, 'Metformin', list, false),
              _buildMedicationChip(context, 'Atorvastatin', list, false),
              _buildMedicationChip(context, 'Albuterol', list, false),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spaceSm),
        _buildCustomMedicationField(context, list),
      ],
    );
  }

  Widget _buildMedicationChip(
      BuildContext context,
      String label,
      RxList<String> list,
      bool isDefault) {
    final isSelected = list.contains(label) || (isDefault && list.isEmpty);

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (label == 'None' && selected) {
          list.assignAll(['None']);
        } else if (label == 'None' && !selected) {
          list.remove('None');
        } else {
          if (selected) {
            list.remove('None');
            if (!list.contains(label)) list.add(label);
          } else {
            list.remove(label);
          }
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

  Widget _buildCustomMedicationField(BuildContext context, RxList<String> list) {
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
          if (value.trim().isNotEmpty) {
            list.remove('None');
            if (!list.contains(value.trim())) {
              list.add(value.trim());
            }
          }
        },
      ),
    );
  }
}
