import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../controller/patient_profile_controller.dart';
import '../widgets/critical_banner.dart';
import '../widgets/demographics_card.dart';
import '../widgets/visit_timeline.dart';

class PatientProfileView extends GetView<PatientProfileController> {
  const PatientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final p = controller.patient.value;
          if (p == null) return const Text('Patient Profile');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p.fullName),
              Text(
                'ID: ${p.id} • ${p.age} yrs',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          );
        }),
      ),
      body: Obx(() {
        switch (controller.viewState.value) {
          case ViewState.loading:
            return const LoadingView(
              message: 'Loading patient clinical profile...',
            );
          case ViewState.error:
            return ErrorStateView(
              message: controller.errorMessage.value,
              onRetry: () {
                final p = controller.patient.value;
                if (p != null) controller.loadProfile(p.id);
              },
            );
          case ViewState.empty:
          case ViewState.initial:
          case ViewState.success:
            final p = controller.patient.value;
            if (p == null) {
              return const ErrorStateView(message: 'No patient selected.');
            }

            final hasAllergies = p.allergies.isNotEmpty;
            final isCritical = p.status.toLowerCase() == 'critical';

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Critical Alert / Allergy Banner
                  if (isCritical || hasAllergies) ...[
                    CriticalBanner(
                      title: isCritical
                          ? 'CRITICAL STATUS ALERT'
                          : 'ALLERGY WARNING',
                      message: hasAllergies
                          ? 'Patient has documented allergies: ${p.allergies.join(', ')}'
                          : 'Patient condition flagged as Critical. Immediate monitoring required.',
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                  ],

                  // Demographics Card
                  DemographicsCard(
                    patient: p,
                    onEditPressed: controller.editDemographics,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),

                  // Medical Information Summary Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.spaceLg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.medication_outlined,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: AppConstants.spaceSm),
                              Text(
                                'Medical Summary',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppConstants.spaceMd),
                          const Divider(height: 1),
                          const SizedBox(height: AppConstants.spaceMd),

                          // Allergies List
                          Text(
                            'Known Allergies',
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.destructive,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spaceSm),
                          if (p.allergies.isEmpty)
                            Text(
                              'No known allergies reported.',
                              style: theme.textTheme.bodyMedium,
                            )
                          else
                            Wrap(
                              spacing: AppConstants.spaceSm,
                              runSpacing: AppConstants.spaceSm,
                              children: p.allergies.map((allergy) {
                                return Chip(
                                  avatar: const Icon(
                                    Icons.warning_amber_rounded,
                                    size: 16,
                                    color: AppColors.destructive,
                                  ),
                                  label: Text(allergy),
                                  backgroundColor: AppColors.destructive
                                      .withValues(alpha: 0.1),
                                  side: BorderSide(
                                    color: AppColors.destructive
                                        .withValues(alpha: 0.3),
                                  ),
                                );
                              }).toList(),
                            ),
                          const SizedBox(height: AppConstants.spaceMd),

                          // Current Medications
                          Text(
                            'Current Medications',
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spaceSm),
                          if (p.currentMedications.isEmpty)
                            Text(
                              'No active medications listed.',
                              style: theme.textTheme.bodyMedium,
                            )
                          else
                            Wrap(
                              spacing: AppConstants.spaceSm,
                              runSpacing: AppConstants.spaceSm,
                              children: p.currentMedications.map((med) {
                                return Chip(
                                  avatar: const Icon(
                                    Icons.vaccines_outlined,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                  label: Text(med),
                                  backgroundColor: AppColors.primary
                                      .withValues(alpha: 0.1),
                                  side: BorderSide(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.3),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.spaceMd),

                  // Visit Timeline Card
                  VisitTimeline(
                    appointments: controller.visitHistory,
                    onBookAppointmentPressed:
                        controller.navigateToBookAppointment,
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}
