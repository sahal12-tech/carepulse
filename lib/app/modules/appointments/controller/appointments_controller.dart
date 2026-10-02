import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/appointment.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../routes/app_routes.dart';

class AppointmentsController extends GetxController {
  final AppointmentRepository _appointmentRepository = Get.find<AppointmentRepository>();

  final RxList<Appointment> appointments = <Appointment>[].obs;
  final Rx<String> selectedTab = 'Day'.obs; // Day, Week, Month
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<ViewState> viewState = ViewState.initial.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    viewState.value = ViewState.loading;
    errorMessage.value = '';

    try {
      final appts = await _appointmentRepository.getAppointments();
      appointments.assignAll(appts);

      if (appts.isEmpty) {
        viewState.value = ViewState.empty;
      } else {
        viewState.value = ViewState.success;
      }
    } catch (e) {
      viewState.value = ViewState.error;
      errorMessage.value = 'Failed to load appointments: ${e.toString()}';
    }
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  void changeDate(DateTime date) {
    selectedDate.value = date;
  }

  List<Appointment> getFilteredAppointments() {
    // Filter appointments based on selected date and tab view
    // For now, return all appointments - filtering logic can be added later
    return appointments;
  }

  void navigateToAddAppointment() {
    Get.toNamed(AppRoutes.appointments); // This would typically go to a form
  }
}