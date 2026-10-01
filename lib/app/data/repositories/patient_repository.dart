import '../models/patient.dart';

abstract class PatientRepository {
  Future<List<Patient>> getPatients();
  Future<Patient?> getPatientById(String id);
  Future<List<Patient>> searchPatients(String query);
  Future<Patient> createPatient(Patient patient);
  Future<Patient> updatePatient(Patient patient);
}

class MockPatientRepository implements PatientRepository {
  final List<Patient> _patients = [
    Patient(
      id: 'P-1001',
      firstName: 'Eleanor',
      lastName: 'Vance',
      dateOfBirth: DateTime(1985, 4, 12),
      gender: 'Female',
      phone: '(555) 234-5678',
      email: 'eleanor.vance@example.com',
      insuranceProvider: 'BlueCross Shield',
      insuranceNumber: 'BCS-994821',
      allergies: ['Penicillin', 'Peanuts'],
      currentMedications: ['Lisinopril 10mg', 'Metformin 500mg'],
      emergencyContactName: 'Thomas Vance',
      emergencyContactPhone: '(555) 876-5432',
      primaryCarePhysician: 'Dr. Sarah Jenkins',
      bloodType: 'O+',
      status: 'Active',
    ),
    Patient(
      id: 'P-1002',
      firstName: 'Marcus',
      lastName: 'Brody',
      dateOfBirth: DateTime(1962, 11, 30),
      gender: 'Male',
      phone: '(555) 345-6789',
      email: 'mbrody@university.edu',
      insuranceProvider: 'Aetna Health',
      insuranceNumber: 'AET-883192',
      allergies: ['Sulfa drugs'],
      currentMedications: ['Atorvastatin 20mg'],
      emergencyContactName: 'Marion Brody',
      emergencyContactPhone: '(555) 765-4321',
      primaryCarePhysician: 'Dr. Robert Chen',
      bloodType: 'A-',
      status: 'Active',
    ),
    Patient(
      id: 'P-1003',
      firstName: 'Clara',
      lastName: 'Oswald',
      dateOfBirth: DateTime(1991, 8, 23),
      gender: 'Female',
      phone: '(555) 456-7890',
      email: 'clara.oswald@example.com',
      insuranceProvider: 'United Healthcare',
      insuranceNumber: 'UHC-771234',
      allergies: ['Latex'],
      currentMedications: ['Albuterol Inhaler'],
      emergencyContactName: 'Danny Pink',
      emergencyContactPhone: '(555) 654-3210',
      primaryCarePhysician: 'Dr. Sarah Jenkins',
      bloodType: 'B+',
      status: 'Critical',
    ),
    Patient(
      id: 'P-1004',
      firstName: 'Arthur',
      lastName: 'Dent',
      dateOfBirth: DateTime(1978, 3, 15),
      gender: 'Male',
      phone: '(555) 567-8901',
      email: 'arthur.dent@galaxy.org',
      insuranceProvider: 'Kaiser Permanente',
      insuranceNumber: 'KP-424242',
      allergies: [],
      currentMedications: ['Multivitamins'],
      emergencyContactName: 'Ford Prefect',
      emergencyContactPhone: '(555) 543-2109',
      primaryCarePhysician: 'Dr. Lisa Ray',
      bloodType: 'AB+',
      status: 'Inactive',
    ),
  ];

  @override
  Future<List<Patient>> getPatients() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_patients);
  }

  @override
  Future<Patient?> getPatientById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _patients.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Patient>> searchPatients(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (query.trim().isEmpty) return List.from(_patients);
    
    final q = query.toLowerCase().trim();
    return _patients.where((p) {
      return p.fullName.toLowerCase().contains(q) ||
          p.id.toLowerCase().contains(q) ||
          p.phone.contains(q) ||
          p.email.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Future<Patient> createPatient(Patient patient) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final newPatient = Patient(
      id: 'P-${1000 + _patients.length + 1}',
      firstName: patient.firstName,
      lastName: patient.lastName,
      dateOfBirth: patient.dateOfBirth,
      gender: patient.gender,
      phone: patient.phone,
      email: patient.email,
      insuranceProvider: patient.insuranceProvider,
      insuranceNumber: patient.insuranceNumber,
      allergies: patient.allergies,
      currentMedications: patient.currentMedications,
      emergencyContactName: patient.emergencyContactName,
      emergencyContactPhone: patient.emergencyContactPhone,
      primaryCarePhysician: patient.primaryCarePhysician,
      bloodType: patient.bloodType,
      status: 'Active',
    );
    _patients.insert(0, newPatient);
    return newPatient;
  }

  @override
  Future<Patient> updatePatient(Patient patient) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _patients.indexWhere((p) => p.id == patient.id);
    if (index != -1) {
      _patients[index] = patient;
    }
    return patient;
  }
}
