import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/appointment.dart';
import '../../../data/models/patient.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../data/repositories/patient_repository.dart';

class AppointmentsController extends GetxController {
  final AppointmentRepository _appointmentRepository = Get.find<AppointmentRepository>();
  final PatientRepository _patientRepository = Get.find<PatientRepository>();

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxString selectedStatusFilter = 'All'.obs;

  final RxList<Appointment> allAppointments = <Appointment>[].obs;
  final RxList<Appointment> filteredAppointments = <Appointment>[].obs;
  final RxList<Patient> patientList = <Patient>[].obs;

  final Rx<ViewState> viewState = ViewState.initial.obs;
  final RxString errorMessage = ''.obs;

  final List<String> statusFilterOptions = [
    'All',
    'Confirmed',
    'In Progress',
    'Completed',
    'No Show',
    'Cancelled'
  ];

  @override
  void onInit() {
    super.onInit();
    loadAppointments();
    loadPatients();
  }

  Future<void> loadAppointments() async {
    viewState.value = ViewState.loading;
    errorMessage.value = '';

    try {
      final list = await _appointmentRepository.getAppointments();
      allAppointments.assignAll(list);
      _applyFilters();
    } catch (e) {
      viewState.value = ViewState.error;
      errorMessage.value = 'Failed to load appointments schedule: ${e.toString()}';
    }
  }

  Future<void> loadPatients() async {
    try {
      final pts = await _patientRepository.getPatients();
      patientList.assignAll(pts);
    } catch (_) {}
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
    _applyFilters();
  }

  void setStatusFilter(String filter) {
    selectedStatusFilter.value = filter;
    _applyFilters();
  }

  void _applyFilters() {
    List<Appointment> result = List.from(allAppointments);

    // Filter by selected date
    final date = selectedDate.value;
    result = result.where((apt) {
      return apt.dateTime.year == date.year &&
          apt.dateTime.month == date.month &&
          apt.dateTime.day == date.day;
    }).toList();

    // Filter by status chip
    if (selectedStatusFilter.value != 'All') {
      final filterKey = selectedStatusFilter.value.toLowerCase().replaceAll(' ', '_');
      result = result.where((apt) => apt.status.toLowerCase() == filterKey).toList();
    }

    filteredAppointments.assignAll(result);

    if (result.isEmpty) {
      viewState.value = ViewState.empty;
    } else {
      viewState.value = ViewState.success;
    }
  }

  Future<void> updateStatus(String id, String newStatus) async {
    try {
      await _appointmentRepository.updateAppointmentStatus(id, newStatus);
      await loadAppointments();
      Get.snackbar(
        'Status Updated',
        'Appointment status changed to $newStatus',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update appointment status.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> bookNewAppointment({
    required String patientId,
    required String patientName,
    required String doctorName,
    required DateTime dateTime,
    required String type,
    required String notes,
  }) async {
    viewState.value = ViewState.loading;
    try {
      final newApt = Appointment(
        id: '',
        patientId: patientId,
        patientName: patientName,
        doctorId: 'DOC-1',
        doctorName: doctorName,
        dateTime: dateTime,
        type: type,
        status: 'confirmed',
        notes: notes,
      );

      await _appointmentRepository.createAppointment(newApt);
      await loadAppointments();

      Get.snackbar(
        'Appointment Scheduled',
        'Successfully booked consultation for $patientName',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      viewState.value = ViewState.error;
      errorMessage.value = 'Failed to schedule appointment: ${e.toString()}';
    }
  }
}
