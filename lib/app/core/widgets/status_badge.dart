import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final statusConfig = _getStatusConfig(status);

    return Semantics(
      label: 'Status: ${statusConfig.label}',
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceSm + 2,
          vertical: AppConstants.spaceXs,
        ),
        decoration: BoxDecoration(
          color: statusConfig.color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppConstants.radiusSm),
          border: Border.all(
            color: statusConfig.color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              statusConfig.icon,
              size: 14,
              color: statusConfig.color,
            ),
            const SizedBox(width: AppConstants.spaceXs + 2),
            Text(
              statusConfig.label,
              style: TextStyle(
                fontFamily: AppConstants.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: statusConfig.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _StatusConfig _getStatusConfig(String status) {
    final s = status.toLowerCase().replaceAll(' ', '_');
    switch (s) {
      case 'confirmed':
        return _StatusConfig(
          label: 'Confirmed',
          color: AppColors.statusConfirmed,
          icon: Icons.check_circle_outline,
        );
      case 'in_progress':
      case 'in progress':
        return _StatusConfig(
          label: 'In Progress',
          color: AppColors.statusInProgress,
          icon: Icons.pending_actions_outlined,
        );
      case 'completed':
        return _StatusConfig(
          label: 'Completed',
          color: AppColors.statusCompleted,
          icon: Icons.task_alt,
        );
      case 'noshow':
      case 'no_show':
      case 'no show':
        return _StatusConfig(
          label: 'No Show',
          color: AppColors.statusNoShow,
          icon: Icons.cancel_outlined,
        );
      case 'cancelled':
        return _StatusConfig(
          label: 'Cancelled',
          color: AppColors.statusCancelled,
          icon: Icons.block,
        );
      case 'scheduled':
      default:
        return _StatusConfig(
          label: 'Scheduled',
          color: AppColors.primary,
          icon: Icons.event_available,
        );
    }
  }
}

class _StatusConfig {
  final String label;
  final Color color;
  final IconData icon;

  _StatusConfig({
    required this.label,
    required this.color,
    required this.icon,
  });
}
