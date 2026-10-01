import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../data/models/patient.dart';

class PatientTable extends StatelessWidget {
  final List<Patient> patients;
  final Function(String patientId) onSelectPatient;

  const PatientTable({
    super.key,
    required this.patients,
    required this.onSelectPatient,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 32,
          ),
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              theme.colorScheme.primary.withValues(alpha: 0.05),
            ),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Age/Gender')),
              DataColumn(label: Text('Phone')),
              DataColumn(label: Text('PCP')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Action')),
            ],
            rows: patients.map((p) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      p.id,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(Text(p.fullName)),
                  DataCell(Text('${p.age}y / ${p.gender}')),
                  DataCell(Text(p.phone)),
                  DataCell(Text(p.primaryCarePhysician)),
                  DataCell(StatusBadge(status: p.status)),
                  DataCell(
                    OutlinedButton.icon(
                      onPressed: () => onSelectPatient(p.id),
                      icon: const Icon(Icons.visibility_outlined, size: 16),
                      label: const Text('View Profile'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 36),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spaceSm + 4,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
