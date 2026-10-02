import 'package:get/get.dart';
import '../../../data/models/patient.dart';
import '../../../data/repositories/patient_repository.dart';
import '../../../core/constants/app_constants.dart';

class ProfileController extends GetxController {
  final PatientRepository _patientRepository = Get.find<PatientRepository>();

  final Rx<Patient?> patient = Rx<Patient?>(null);
  final Rx<ViewState> viewState = ViewState.initial.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadPatient();
  }

  Future<void> loadPatient() async {
    final args = Get.arguments as Map<String, dynamic>?;
    final patientId = args?['id'] as String?;
    if (patientId == null) {
      viewState.value = ViewState.error;
      errorMessage.value = 'Patient ID not provided';
      return;
    }

    viewState.value = ViewState.loading;
    errorMessage.value = '';

    try {
      final p = await _patientRepository.getPatientById(patientId);
      if (p == null) {
        viewState.value = ViewState.empty;
        errorMessage.value = 'Patient not found';
      } else {
        patient.value = p;
        viewState.value = ViewState.success;
      }
    } catch (e) {
      viewState.value = ViewState.error;
      errorMessage.value = 'Failed to load patient: ${e.toString()}';
    }
  }

  void reload() {
    loadPatient();
  }
}