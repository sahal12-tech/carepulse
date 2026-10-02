import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../controller/registration_controller.dart';

class RegistrationStepper extends StatefulWidget {
  final List<Widget> steps;
  final List<String> stepTitles;

  const RegistrationStepper({
    super.key,
    required this.steps,
    required this.stepTitles,
  });

  @override
  State<RegistrationStepper> createState() => _RegistrationStepperState();
}

class _RegistrationStepperState extends State<RegistrationStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<RegistrationController>();

    if (widget.steps.isEmpty) return const SizedBox.shrink();

    final isLastStep = _currentStep == widget.steps.length - 1;

    return Column(
      children: [
        // Stepper Progress Header
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceMd,
            vertical: AppConstants.spaceSm,
          ),
          color: theme.colorScheme.primary.withValues(alpha: 0.08),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Step ${_currentStep + 1} of ${widget.steps.length}: ${widget.stepTitles[_currentStep]}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '${((_currentStep + 1) / widget.steps.length * 100).round()}% Completed',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spaceSm),
              LinearProgressIndicator(
                value: (_currentStep + 1) / widget.steps.length,
                backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
                color: AppColors.primary,
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
            ],
          ),
        ),

        // Current Step Content Body
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spaceMd),
            child: widget.steps[_currentStep],
          ),
        ),

        // Error message if any
        Obx(() {
          if (controller.errorMessage.value.isEmpty) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceMd),
            child: Container(
              padding: const EdgeInsets.all(AppConstants.spaceSm),
              decoration: BoxDecoration(
                color: AppColors.destructive.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                border: Border.all(
                  color: AppColors.destructive.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.destructive,
                    size: 20,
                  ),
                  const SizedBox(width: AppConstants.spaceSm),
                  Expanded(
                    child: Text(
                      controller.errorMessage.value,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.destructive,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),

        // Bottom Stepper Action Bar
        Card(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spaceMd),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep > 0)
                  OutlinedButton.icon(
                    onPressed: () {
                      setState(() => _currentStep--);
                      controller.errorMessage.value = '';
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                  )
                else
                  const SizedBox.shrink(),

                if (!isLastStep)
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() => _currentStep++);
                      controller.errorMessage.value = '';
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next Step'),
                  )
                else
                  Obx(
                    () => ElevatedButton.icon(
                      onPressed: controller.isSubmitting.value
                          ? null
                          : controller.submitRegistration,
                      icon: controller.isSubmitting.value
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.onAccent,
                              ),
                            )
                          : const Icon(Icons.check_circle),
                      label: const Text('Complete Registration'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.onAccent,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
