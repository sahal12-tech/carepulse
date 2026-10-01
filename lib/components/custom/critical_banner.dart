import 'package:flutter/material.dart';

class CriticalBanner extends StatelessWidget {
  final String message;
  final IconData icon;

  const CriticalBanner({
    super.key,
    required this.message,
    this.icon = Icons.warning_amber,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.error,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.onError,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onError,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
