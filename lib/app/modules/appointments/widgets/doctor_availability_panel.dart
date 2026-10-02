import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_colors.dart';

class DoctorAvailabilityPanel extends StatelessWidget {
  const DoctorAvailabilityPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppConstants.spaceMd),
          child: Text(
            'Doctor Availability',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppConstants.spaceSm),
            children: [
              _buildDoctorItem(
                context,
                'Dr. Sarah Jenkins',
                'Cardiology',
                'Available',
                Icons.medical_services,
                AppColors.primary,
              ),
              _buildDoctorItem(
                context,
                'Dr. Robert Chen',
                'Neurology',
                'Busy',
                Icons.medical_services,
                AppColors.secondary,
              ),
              _buildDoctorItem(
                context,
                'Dr. Lisa Ray',
                'Pediatrics',
                'Available',
                Icons.medical_services,
                AppColors.accent,
              ),
              _buildDoctorItem(
                context,
                'Dr. Mike Wilson',
                'Dermatology',
                'Offline',
                Icons.medical_services,
                AppColors.destructive,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorItem(
    BuildContext context,
    String name,
    String specialty,
    String status,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spaceXs),
      padding: const EdgeInsets.all(AppConstants.spaceSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: AppConstants.spaceSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  specialty,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spaceXs,
              vertical: AppConstants.spaceXs / 2,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}