class Patient {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String gender;
  final String phone;
  final String email;
  final String insuranceProvider;
  final String insuranceNumber;
  final List<String> allergies;
  final List<String> currentMedications;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String primaryCarePhysician;
  final String bloodType;
  final String status; // Active, Inactive, Critical

  const Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    this.gender = 'Unspecified',
    required this.phone,
    required this.email,
    required this.insuranceProvider,
    required this.insuranceNumber,
    required this.allergies,
    required this.currentMedications,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.primaryCarePhysician,
    this.bloodType = 'A+',
    this.status = 'Active',
  });

  String get fullName => '$firstName $lastName';

  int get age {
    final today = DateTime.now();
    int age = today.year - dateOfBirth.year;
    if (today.month < dateOfBirth.month ||
        (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json['id'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
        gender: json['gender'] as String? ?? 'Unspecified',
        phone: json['phone'] as String,
        email: json['email'] as String,
        insuranceProvider: json['insuranceProvider'] as String,
        insuranceNumber: json['insuranceNumber'] as String,
        allergies: List<String>.from(json['allergies'] ?? []),
        currentMedications: List<String>.from(json['currentMedications'] ?? []),
        emergencyContactName: json['emergencyContactName'] as String,
        emergencyContactPhone: json['emergencyContactPhone'] as String,
        primaryCarePhysician: json['primaryCarePhysician'] as String,
        bloodType: json['bloodType'] as String? ?? 'A+',
        status: json['status'] as String? ?? 'Active',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth.toIso8601String(),
        'gender': gender,
        'phone': phone,
        'email': email,
        'insuranceProvider': insuranceProvider,
        'insuranceNumber': insuranceNumber,
        'allergies': allergies,
        'currentMedications': currentMedications,
        'emergencyContactName': emergencyContactName,
        'emergencyContactPhone': emergencyContactPhone,
        'primaryCarePhysician': primaryCarePhysician,
        'bloodType': bloodType,
        'status': status,
      };
}
