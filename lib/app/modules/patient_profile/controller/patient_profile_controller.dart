import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/appointment.dart';
import '../../../data/models/patient.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../data/repositories/patient_repository.dart';
import '../../../routes/app_routes.dart';

class PatientProfileController extends GetxController {
  final PatientRepository _patientRepository = Get.find<PatientRepository>();
  final AppointmentRepository _appointmentRepository = Get.find<AppointmentRepository>();

  final Rx<Patient?> patient = Rx<Patient?>(null);
  final RxList<Appointment> visitHistory = <Appointment>[].obs;

  final Rx<ViewState> viewState = ViewState.initial.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    String? patientId;

    if (args is Map && args.containsKey('id')) {
      patientId = args['id'] as String?;
    } else if (Get.parameters.containsKey('id')) {
      patientId = Get.parameters['id'];
    }

    if (patientId != null && patientId.isNotEmpty) {
      loadProfile(patientId);
    } else {
      // Fallback to first patient if no ID passed (testing mode)
      loadProfile('P-1001');
    }
  }

  Future<void> loadProfile(String patientId) async {
    viewState.value = ViewState.loading;
    errorMessage.value = '';

    try {
      final loadedPatient = await _patientRepository.getPatientById(patientId);
      if (loadedPatient == null) {
        viewState.value = ViewState.error;
        errorMessage.value = 'Patient record ($patientId) not found.';
        return;
      }

      patient.value = loadedPatient;

      // Load patient appointments
      final allAppointments = await _appointmentRepository.getAppointments();
      final patientApts = allAppointments
          .where((a) => a.patientId == patientId || a.patientName == loadedPatient.fullName)
          .toList();

      visitHistory.assignAll(patientApts);
      viewState.value = ViewState.success;
    } catch (e) {
      viewState.value = ViewState.error;
      errorMessage.value = 'Failed to load profile: ${e.toString()}';
    }
  }

  void navigateToBookAppointment() {
    Get.toNamed(AppRoutes.appointments);
  }

  void editDemographics() {
    Get.snackbar(
      'Edit Patient',
      'Patient demographics editing features will be saved directly via API repository.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
