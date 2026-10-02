import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../controller/appointments_controller.dart';
import '../widgets/appointment_schedule_grid.dart';
import '../widgets/doctor_availability_panel.dart';

class AppointmentsView extends StatefulWidget {
  const AppointmentsView({super.key});

  @override
  State<AppointmentsView> createState() => _AppointmentsViewState();
}

class _AppointmentsViewState extends State<AppointmentsView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    // Update controller when tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final tabs = ['Day', 'Week', 'Month'];
        Get.find<AppointmentsController>().changeTab(tabs[_tabController.index]);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            tooltip: 'Today',
            onPressed: () => Get.find<AppointmentsController>()
                .changeDate(DateTime.now()),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            tooltip: 'Select Date',
            onPressed: () => _showDatePicker(context),
          ),
        ],
      ),
      body: Obx(() {
        final controller = Get.find<AppointmentsController>();
        switch (controller.viewState.value) {
          case ViewState.loading:
            return const LoadingView(message: 'Loading appointments...');
          case ViewState.error:
            return ErrorStateView(
              message: controller.errorMessage.value,
              onRetry: controller.loadAppointments,
            );
          case ViewState.empty:
            return EmptyStateView(
              icon: Icons.event_busy,
              title: 'No Appointments',
              message: 'No appointments found.',
              actionLabel: 'Schedule Appointment',
              onActionPressed: controller.navigateToAddAppointment,
            );
          case ViewState.initial:
          case ViewState.success:
            return Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Day'),
                    Tab(text: 'Week'),
                    Tab(text: 'Month'),
                  ],
                ),
                const SizedBox(height: AppConstants.spaceSm),
                Expanded(
                  child: Row(
                    children: [
                      // Main schedule area
                      Expanded(
                        flex: 3,
                        child: AppointmentScheduleGrid(
                          appointments: controller.getFilteredAppointments(),
                          selectedDate: controller.selectedDate.value,
                          viewType: controller.selectedTab.value,
                        ),
                      ),
                      // Doctor availability side panel
                      Container(
                        width: 280,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                        ),
                        child: const DoctorAvailabilityPanel(),
                      ),
                    ],
                  ),
                ),
              ],
            );
        }
      }),
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: Get.find<AppointmentsController>().selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null &&
        picked != Get.find<AppointmentsController>().selectedDate.value) {
      Get.find<AppointmentsController>().changeDate(picked);
    }
  }
}