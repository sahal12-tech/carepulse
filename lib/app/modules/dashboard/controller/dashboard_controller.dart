import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/appointment.dart';
import '../../../data/models/patient.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/patient_repository.dart';
import '../../../routes/app_routes.dart';

class DashboardController extends GetxController {
  final AppointmentRepository _appointmentRepository = Get.find<AppointmentRepository>();
  final PatientRepository _patientRepository = Get.find<PatientRepository>();
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  final Rx<ViewState> viewState = ViewState.initial.obs;
  final RxString errorMessage = ''.obs;

  final RxList<Appointment> todayAppointments = <Appointment>[].obs;
  final RxList<Patient> patients = <Patient>[].obs;

  final RxInt totalPatientsCount = 0.obs;
  final RxInt todayAppointmentsCount = 0.obs;
  final RxInt inProgressCount = 0.obs;
  final RxInt completedCount = 0.obs;

  String get currentUsername => _authRepository.getCurrentUsername() ?? 'Dr. Sarah Jenkins';
  UserRole get currentRole => _authRepository.getCurrentRole() ?? UserRole.receptionist;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    viewState.value = ViewState.loading;
    errorMessage.value = '';

    try {
      final apts = await _appointmentRepository.getTodayAppointments();
      final pts = await _patientRepository.getPatients();

      todayAppointments.assignAll(apts);
      patients.assignAll(pts);

      totalPatientsCount.value = pts.length;
      todayAppointmentsCount.value = apts.length;
      inProgressCount.value = apts.where((a) => a.status == 'in_progress').length;
      completedCount.value = apts.where((a) => a.status == 'completed').length;

      if (apts.isEmpty) {
        viewState.value = ViewState.empty;
      } else {
        viewState.value = ViewState.success;
      }
    } catch (e) {
      viewState.value = ViewState.error;
      errorMessage.value = 'Failed to load dashboard data: ${e.toString()}';
    }
  }

  Future<void> updateAppointmentStatus(String id, String newStatus) async {
    try {
      await _appointmentRepository.updateAppointmentStatus(id, newStatus);
      await loadDashboardData();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update appointment status',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void logout() async {
    await _authRepository.logout();
    Get.offAllNamed(AppRoutes.login);
  }

  void navigateToAddPatient() {
    Get.toNamed(AppRoutes.registration);
  }

  void navigateToAppointments() {
    Get.toNamed(AppRoutes.appointments);
  }

  void navigateToPatientDirectory() {
    Get.toNamed(AppRoutes.patients);
  }
}
