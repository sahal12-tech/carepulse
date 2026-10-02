import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/patient.dart';
import '../controller/appointments_controller.dart';

class BookingDialog extends StatefulWidget {
  const BookingDialog({super.key});

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  Patient? _selectedPatient;
  String _doctorName = 'Dr. Sarah Jenkins';
  String _visitType = 'Consultation';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);

  final List<String> _doctors = [
    'Dr. Sarah Jenkins',
    'Dr. Robert Chen',
    'Dr. Lisa Ray',
  ];

  final List<String> _visitTypes = [
    'Consultation',
    'Follow-up',
    'Routine Checkup',
    'Emergency',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<AppointmentsController>();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spaceLg),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.event_available,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: AppConstants.spaceSm),
                          Text(
                            'Book New Appointment',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  const Divider(height: 1),
                  const SizedBox(height: AppConstants.spaceMd),

                  // Select Patient Dropdown
                  Text('Select Patient', style: theme.textTheme.labelLarge),
                  const SizedBox(height: AppConstants.spaceSm),
                  DropdownButtonFormField<Patient>(
                    initialValue: _selectedPatient,
                    decoration: const InputDecoration(
                      hintText: 'Choose patient from directory',
                      prefixIcon: Icon(Icons.person_search_outlined),
                    ),
                    items: controller.patientList.map((p) {
                      return DropdownMenuItem<Patient>(
                        value: p,
                        child: Text('${p.fullName} (${p.id})'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedPatient = val;
                      });
                    },
                    validator: (val) =>
                        val == null ? 'Please select a patient' : null,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),

                  // Select Doctor Dropdown
                  Text('Attending Physician', style: theme.textTheme.labelLarge),
                  const SizedBox(height: AppConstants.spaceSm),
                  DropdownButtonFormField<String>(
                    initialValue: _doctorName,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.medical_services_outlined),
                    ),
                    items: _doctors.map((doc) {
                      return DropdownMenuItem<String>(
                        value: doc,
                        child: Text(doc),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _doctorName = val);
                    },
                  ),
                  const SizedBox(height: AppConstants.spaceMd),

                  // Visit Type Dropdown
                  Text('Type of Visit', style: theme.textTheme.labelLarge),
                  const SizedBox(height: AppConstants.spaceSm),
                  DropdownButtonFormField<String>(
                    initialValue: _visitType,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.merge_type_outlined),
                    ),
                    items: _visitTypes.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _visitType = val);
                    },
                  ),
                  const SizedBox(height: AppConstants.spaceMd),

                  // Date & Time Selectors Row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date', style: theme.textTheme.labelLarge),
                            const SizedBox(height: AppConstants.spaceSm),
                            OutlinedButton.icon(
                              onPressed: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate,
                                  firstDate: DateTime.now()
                                      .subtract(const Duration(days: 1)),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)),
                                );
                                if (picked != null) {
                                  setState(() => _selectedDate = picked);
                                }
                              },
                              icon: const Icon(Icons.calendar_today, size: 16),
                              label: Text(
                                '${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppConstants.spaceMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Time', style: theme.textTheme.labelLarge),
                            const SizedBox(height: AppConstants.spaceSm),
                            OutlinedButton.icon(
                              onPressed: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: _selectedTime,
                                );
                                if (picked != null) {
                                  setState(() => _selectedTime = picked);
                                }
                              },
                              icon: const Icon(Icons.access_time, size: 16),
                              label: Text(_selectedTime.format(context)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spaceMd),

                  // Notes
                  Text('Clinical / Visit Notes', style: theme.textTheme.labelLarge),
                  const SizedBox(height: AppConstants.spaceSm),
                  TextFormField(
                    controller: _notesController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      hintText: 'Enter reason for visit or clinical notes...',
                      prefixIcon: Icon(Icons.note_alt_outlined),
                    ),
                  ),
                  const SizedBox(height: AppConstants.spaceLg),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: AppConstants.spaceMd),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final appointmentDateTime = DateTime(
                              _selectedDate.year,
                              _selectedDate.month,
                              _selectedDate.day,
                              _selectedTime.hour,
                              _selectedTime.minute,
                            );

                            controller.bookNewAppointment(
                              patientId: _selectedPatient!.id,
                              patientName: _selectedPatient!.fullName,
                              doctorName: _doctorName,
                              dateTime: appointmentDateTime,
                              type: _visitType,
                              notes: _notesController.text,
                            );

                            Get.back();
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Confirm Booking'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
