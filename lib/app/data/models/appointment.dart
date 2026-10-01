class Appointment {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final DateTime dateTime;
  final String type; // Consultation, Follow-up, Routine Checkup, Emergency
  final String status; // scheduled, confirmed, in_progress, completed, noshow, cancelled
  final String notes;

  const Appointment({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.dateTime,
    required this.type,
    required this.status,
    this.notes = '',
  });

  String get formattedDate {
    return '${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}/${dateTime.year}';
  }

  String get formattedTime {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  String get formattedDateTime => '$formattedDate at $formattedTime';

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json['id'] as String,
        patientId: json['patientId'] as String,
        patientName: json['patientName'] as String,
        doctorId: json['doctorId'] as String? ?? 'doc-1',
        doctorName: json['doctorName'] as String,
        dateTime: DateTime.parse(json['dateTime'] as String),
        type: json['type'] as String,
        status: json['status'] as String,
        notes: json['notes'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'patientId': patientId,
        'patientName': patientName,
        'doctorId': doctorId,
        'doctorName': doctorName,
        'dateTime': dateTime.toIso8601String(),
        'type': type,
        'status': status,
        'notes': notes,
      };

  Appointment copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? doctorId,
    String? doctorName,
    DateTime? dateTime,
    String? type,
    String? status,
    String? notes,
  }) {
    return Appointment(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }
}
