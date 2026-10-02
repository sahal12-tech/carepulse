import 'package:flutter/material.dart';

class RegistrationStepper extends StatelessWidget {
  final List<Widget> steps;
  final List<String> stepTitles;

  const RegistrationStepper({
    super.key,
    required this.steps,
    required this.stepTitles,
  });

  @override
  Widget build(BuildContext context) {
    // For simplicity, we'll just show the first step
    // A full implementation would require step management in the controller
    if (steps.isEmpty) return const SizedBox.shrink();
    return steps[0];
  }
}