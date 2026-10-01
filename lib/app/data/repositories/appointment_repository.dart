import '../models/appointment.dart';

abstract class AppointmentRepository {
  Future<List<Appointment>> getAppointments();
  Future<List<Appointment>> getTodayAppointments();
  Future<Appointment> createAppointment(Appointment appointment);
  Future<Appointment> updateAppointmentStatus(String id, String status);
}

class MockAppointmentRepository implements AppointmentRepository {
  final List<Appointment> _appointments = [
    Appointment(
      id: 'APT-201',
      patientId: 'P-1001',
      patientName: 'Eleanor Vance',
      doctorId: 'DOC-1',
      doctorName: 'Dr. Sarah Jenkins',
      dateTime: DateTime.now().copyWith(hour: 9, minute: 30),
      type: 'Routine Checkup',
      status: 'in_progress',
      notes: 'Patient reported mild joint discomfort.',
    ),
    Appointment(
      id: 'APT-202',
      patientId: 'P-1002',
      patientName: 'Marcus Brody',
      doctorId: 'DOC-2',
      doctorName: 'Dr. Robert Chen',
      dateTime: DateTime.now().copyWith(hour: 10, minute: 45),
      type: 'Follow-up',
      status: 'confirmed',
      notes: 'Review BP reading log.',
    ),
    Appointment(
      id: 'APT-203',
      patientId: 'P-1003',
      patientName: 'Clara Oswald',
      doctorId: 'DOC-1',
      doctorName: 'Dr. Sarah Jenkins',
      dateTime: DateTime.now().copyWith(hour: 11, minute: 15),
      type: 'Consultation',
      status: 'confirmed',
      notes: 'Allergy panel test results.',
    ),
    Appointment(
      id: 'APT-204',
      patientId: 'P-1004',
      patientName: 'Arthur Dent',
      doctorId: 'DOC-3',
      doctorName: 'Dr. Lisa Ray',
      dateTime: DateTime.now().copyWith(hour: 14, minute: 0),
      type: 'Routine Checkup',
      status: 'scheduled',
      notes: 'Annual physical examination.',
    ),
  ];

  @override
  Future<List<Appointment>> getAppointments() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_appointments);
  }

  @override
  Future<List<Appointment>> getTodayAppointments() async {
    await Future.delayed(const Duration(milliseconds: 400));
    final now = DateTime.now();
    return _appointments.where((apt) {
      return apt.dateTime.year == now.year &&
          apt.dateTime.month == now.month &&
          apt.dateTime.day == now.day;
    }).toList();
  }

  @override
  Future<Appointment> createAppointment(Appointment appointment) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final newApt = appointment.copyWith(
      id: 'APT-${200 + _appointments.length + 1}',
    );
    _appointments.add(newApt);
    return newApt;
  }

  @override
  Future<Appointment> updateAppointmentStatus(String id, String status) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _appointments.indexWhere((a) => a.id == id);
    if (index != -1) {
      final updated = _appointments[index].copyWith(status: status);
      _appointments[index] = updated;
      return updated;
    }
    throw Exception('Appointment $id not found');
  }
}
