import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../data/models/appointment.dart';

class VisitTimeline extends StatelessWidget {
  final List<Appointment> appointments;
  final VoidCallback? onBookAppointmentPressed;

  const VisitTimeline({
    super.key,
    required this.appointments,
    this.onBookAppointmentPressed,
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
                      Icons.history_edu_outlined,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppConstants.spaceSm),
                    Text(
                      'Clinical Visit Timeline',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (onBookAppointmentPressed != null)
                  ElevatedButton.icon(
                    onPressed: onBookAppointmentPressed,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('New Visit'),
                    style: ElevatedButton.styleFrom(
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

            if (appointments.isEmpty)
              Padding(
                padding: const EdgeInsets.all(AppConstants.spaceLg),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.event_note,
                        size: 48,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: AppConstants.spaceSm),
                      Text(
                        'No Visit History',
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'No previous or upcoming visits recorded for this patient.',
                        style: theme.textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: appointments.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppConstants.spaceMd),
                itemBuilder: (context, index) {
                  final apt = appointments[index];
                  final isLast = index == appointments.length - 1;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline indicator line
                      Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 60,
                              color: AppColors.primary.withValues(alpha: 0.3),
                            ),
                        ],
                      ),
                      const SizedBox(width: AppConstants.spaceMd),

                      // Appointment Details Card
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(AppConstants.spaceSm + 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius:
                                BorderRadius.circular(AppConstants.radiusMd),
                            border: Border.all(
                              color: theme.colorScheme.outline
                                  .withValues(alpha: 0.5),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    apt.formattedDateTime,
                                    style: theme.textTheme.labelMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  StatusBadge(status: apt.status),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${apt.type} • ${apt.doctorName}',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              if (apt.notes.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  'Notes: ${apt.notes}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
