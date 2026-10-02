import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/patient.dart';

class DemographicsCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback? onEditPressed;

  const DemographicsCard({
    super.key,
    required this.patient,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.badge_outlined,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppConstants.spaceSm),
                    Text(
                      'Patient Demographics',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (onEditPressed != null)
                  OutlinedButton.icon(
                    onPressed: onEditPressed,
                    icon: const Icon(Icons.edit_outlined, size: 16),
                    label: const Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 36),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.spaceSm + 4,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppConstants.spaceMd),
            const Divider(height: 1),
            const SizedBox(height: AppConstants.spaceMd),

            // Demographics Grid
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 550;
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: isWide ? 3 : 2,
                  childAspectRatio: isWide ? 2.8 : 2.2,
                  crossAxisSpacing: AppConstants.spaceMd,
                  mainAxisSpacing: AppConstants.spaceSm,
                  children: [
                    _buildInfoTile(theme, 'Full Name', patient.fullName),
                    _buildInfoTile(theme, 'Patient ID', patient.id),
                    _buildInfoTile(theme, 'Date of Birth', '${patient.dateOfBirth.month}/${patient.dateOfBirth.day}/${patient.dateOfBirth.year} (${patient.age} yrs)'),
                    _buildInfoTile(theme, 'Gender', patient.gender),
                    _buildInfoTile(theme, 'Blood Type', patient.bloodType),
                    _buildInfoTile(theme, 'Primary Doctor', patient.primaryCarePhysician),
                    _buildInfoTile(theme, 'Phone', patient.phone),
                    _buildInfoTile(theme, 'Email', patient.email),
                    _buildInfoTile(theme, 'Emergency Contact', '${patient.emergencyContactName}\n${patient.emergencyContactPhone}'),
                    _buildInfoTile(theme, 'Insurance Provider', patient.insuranceProvider),
                    _buildInfoTile(theme, 'Policy/Member ID', patient.insuranceNumber),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(ThemeData theme, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value.isEmpty ? 'N/A' : value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
