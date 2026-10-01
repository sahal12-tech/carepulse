import 'package:flutter/material.dart';

class VitalSignsInput extends StatelessWidget {
  const VitalSignsInput({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vital Signs',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildVitalSignField(
              theme,
              label: 'BP',
              value: '120/80',
              unit: 'mmHg',
            ),
            const SizedBox(width: 16),
            _buildVitalSignField(
              theme,
              label: 'HR',
              value: '72',
              unit: 'bpm',
            ),
            const SizedBox(width: 16),
            _buildVitalSignField(
              theme,
              label: 'Temp',
              value: '98.6',
              unit: '°F',
            ),
            const SizedBox(width: 16),
            _buildVitalSignField(
              theme,
              label: 'SpO2',
              value: '98',
              unit: '%',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVitalSignField(ThemeData theme, {
    required String label,
    required String value,
    required String unit,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$value $unit',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
