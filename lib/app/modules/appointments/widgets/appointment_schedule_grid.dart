import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/appointment.dart';

class AppointmentScheduleGrid extends StatelessWidget {
  final List<Appointment> appointments;
  final DateTime selectedDate;
  final String viewType; // Day, Week, Month

  const AppointmentScheduleGrid({
    super.key,
    required this.appointments,
    required this.selectedDate,
    required this.viewType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Text(
          '$viewType View\n\nSelected Date: ${selectedDate.month}/${selectedDate.day}/${selectedDate.year}\n\n${appointments.length} appointments',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}