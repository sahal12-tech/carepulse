import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../data/models/appointment.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;
  final Function(String status)? onStatusChanged;
  final VoidCallback? onTap;

  const AppointmentTile({
    super.key,
    required this.appointment,
    this.onStatusChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spaceMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.patientName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: AppConstants.spaceXs),
                            Text(
                              appointment.formattedTime,
                              style: theme.textTheme.bodySmall,
                            ),
                            const SizedBox(width: AppConstants.spaceSm),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                appointment.type,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  StatusBadge(status: appointment.status),
                ],
              ),
              if (appointment.notes.isNotEmpty) ...[
                const SizedBox(height: AppConstants.spaceSm),
                Text(
                  'Note: ${appointment.notes}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (onStatusChanged != null) ...[
                const SizedBox(height: AppConstants.spaceSm),
                const Divider(height: 1),
                const SizedBox(height: AppConstants.spaceSm),
                Wrap(
                  spacing: AppConstants.spaceSm,
                  children: [
                    if (appointment.status == 'confirmed' || appointment.status == 'scheduled')
                      OutlinedButton.icon(
                        onPressed: () => onStatusChanged!('in_progress'),
                        icon: const Icon(Icons.play_arrow, size: 16),
                        label: const Text('Start'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 36),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    if (appointment.status == 'in_progress')
                      ElevatedButton.icon(
                        onPressed: () => onStatusChanged!('completed'),
                        icon: const Icon(Icons.check, size: 16),
                        label: const Text('Complete'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0, 36),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    if (appointment.status != 'completed' && appointment.status != 'cancelled')
                      TextButton.icon(
                        onPressed: () => onStatusChanged!('noshow'),
                        icon: const Icon(Icons.cancel_outlined, size: 16),
                        label: const Text('No Show'),
                        style: TextButton.styleFrom(
                          minimumSize: const Size(0, 36),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
