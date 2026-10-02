import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/critical_banner.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../controller/profile_controller.dart';

class PatientProfileView extends GetView<ProfileController> {
  const PatientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final patient = controller.patient.value;
          if (patient == null) {
            return const Text('Patient Profile');
          }
          return Text('${patient.fullName} (${patient.id})');
        }),
      ),
      body: Obx(() {
        switch (controller.viewState.value) {
          case ViewState.loading:
            return const LoadingView(message: 'Loading patient profile...');
          case ViewState.error:
            return ErrorStateView(
              message: controller.errorMessage.value,
              onRetry: controller.reload,
            );
          case ViewState.empty:
            return EmptyStateView(
              icon: Icons.person_off_outlined,
              title: 'Patient Not Found',
              message: 'No patient record found for the provided ID.',
              actionLabel: 'Go Back',
              onActionPressed: () => Get.back(),
            );
          case ViewState.initial:
          case ViewState.success:
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spaceMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCriticalBanner(),
                    const SizedBox(height: AppConstants.spaceMd),
                    const _DemographicsSection(),
                    const SizedBox(height: AppConstants.spaceMd),
                    const _TimelineView(),
                    const SizedBox(height: AppConstants.spaceMd),
                    const _QuickActions(),
                  ],
                ),
              ),
            );
        }
      }),
    );
  }

  Widget _buildCriticalBanner() {
    final patient = controller.patient.value;
    if (patient == null) return const SizedBox.shrink();

    final hasAllergies = patient.allergies.isNotEmpty;
    final isCritical = patient.status.toLowerCase() == 'critical';

    if (!hasAllergies && !isCritical) {
      return const SizedBox.shrink();
    }

    final StringBuffer message = StringBuffer();
    if (hasAllergies) {
      message.write('Allergies: ${patient.allergies.join(', ')}');
    }
    if (isCritical) {
      if (hasAllergies) message.write(' | ');
      message.write('Status: Critical');
    }

    return CriticalBanner(
      title: 'Critical Alert',
      message: message.toString(),
      icon: Icons.warning_amber_rounded,
    );
  }
}

class _DemographicsSection extends StatelessWidget {
  const _DemographicsSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final patient = Get.find<ProfileController>().patient.value;

    if (patient == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Demographics',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spaceSm),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('ID'),
                  _buildLabel('Name'),
                  _buildLabel('Date of Birth'),
                  _buildLabel('Gender'),
                  _buildLabel('Blood Type'),
                  _buildLabel('Phone'),
                  _buildLabel('Email'),
                ],
              ),
            ),
            const SizedBox(width: AppConstants.spaceMd),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildValue(patient.id),
                  _buildValue(patient.fullName),
                  _buildValue('${patient.dateOfBirth.month}/${patient.dateOfBirth.day}/${patient.dateOfBirth.year}'),
                  _buildValue(patient.gender),
                  _buildValue(patient.bloodType),
                  _buildValue(patient.phone),
                  _buildValue(patient.email),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Get.isDarkMode
              ? Colors.white.withValues(alpha: 0.7)
              : Colors.black.withValues(alpha: 0.7),
        ),
      ),
    );
  }

  Widget _buildValue(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _TimelineView extends StatelessWidget {
  const _TimelineView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final patient = Get.find<ProfileController>().patient.value;

    if (patient == null) {
      return const SizedBox.shrink();
    }

    // For now, we'll show placeholder data for timeline.
    // In a real app, we would fetch visits, prescriptions, labs, notes.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Timeline',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spaceSm),
        // Placeholder for timeline entries
        Container(
          padding: const EdgeInsets.all(AppConstants.spaceSm),
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.dividerColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(AppConstants.radiusSm),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No timeline data available.',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spaceSm),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                Icons.add_task,
                'Add Prescription',
                () => Get.snackbar('Feature', 'Add prescription not implemented'),
              ),
            ),
            const SizedBox(width: AppConstants.spaceSm),
            Expanded(
              child: _buildActionButton(
                Icons.add_chart,
                'Add Lab Request',
                () => Get.snackbar('Feature', 'Add lab request not implemented'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spaceSm),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                Icons.calendar_today,
                'Schedule Follow-up',
                () => Get.snackbar('Feature', 'Schedule follow-up not implemented'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
      ),
    );
  }
}