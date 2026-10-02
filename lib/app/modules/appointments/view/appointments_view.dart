import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../controller/appointments_controller.dart';
import '../widgets/booking_dialog.dart';
import '../../dashboard/widgets/appointment_tile.dart';

class AppointmentsView extends GetView<AppointmentsController> {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_task_outlined),
            tooltip: 'Book Appointment',
            onPressed: () => _openBookingDialog(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.loadAppointments,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spaceMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Selector Banner
              Obx(() {
                final date = controller.selectedDate.value;
                final isToday = DateTime.now().year == date.year &&
                    DateTime.now().month == date.month &&
                    DateTime.now().day == date.day;

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spaceMd,
                      vertical: AppConstants.spaceSm,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left),
                          tooltip: 'Previous Day',
                          onPressed: () {
                            controller.setDate(
                              date.subtract(const Duration(days: 1)),
                            );
                          },
                        ),
                        InkWell(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                            );
                            if (picked != null) controller.setDate(picked);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: AppConstants.spaceSm),
                              Text(
                                '${date.month}/${date.day}/${date.year} ${isToday ? '(Today)' : ''}',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          tooltip: 'Next Day',
                          onPressed: () {
                            controller.setDate(
                              date.add(const Duration(days: 1)),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: AppConstants.spaceMd),

              // Status Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: controller.statusFilterOptions.map((filter) {
                      final isSelected =
                          controller.selectedStatusFilter.value == filter;
                      return Padding(
                        padding:
                            const EdgeInsets.only(right: AppConstants.spaceSm),
                        child: FilterChip(
                          label: Text(filter),
                          selected: isSelected,
                          onSelected: (_) =>
                              controller.setStatusFilter(filter),
                          selectedColor: theme.colorScheme.primary
                              .withValues(alpha: 0.2),
                          checkmarkColor: theme.colorScheme.primary,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spaceMd),

              // List of Appointments
              Expanded(
                child: Obx(() {
                  switch (controller.viewState.value) {
                    case ViewState.loading:
                      return const LoadingView(
                        message: 'Fetching appointments schedule...',
                      );
                    case ViewState.error:
                      return ErrorStateView(
                        message: controller.errorMessage.value,
                        onRetry: controller.loadAppointments,
                      );
                    case ViewState.empty:
                      return EmptyStateView(
                        icon: Icons.event_available_outlined,
                        title: 'No Appointments Scheduled',
                        message:
                            'There are no appointments matching your selected date and filter.',
                        actionLabel: 'Book Appointment',
                        onActionPressed: () => _openBookingDialog(context),
                      );
                    case ViewState.initial:
                    case ViewState.success:
                      return ListView.separated(
                        itemCount: controller.filteredAppointments.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: AppConstants.spaceSm),
                        itemBuilder: (context, index) {
                          final apt = controller.filteredAppointments[index];
                          return AppointmentTile(
                            appointment: apt,
                            onStatusChanged: (newStatus) =>
                                controller.updateStatus(apt.id, newStatus),
                          );
                        },
                      );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openBookingDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Book Appointment'),
      ),
    );
  }

  void _openBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const BookingDialog(),
    );
  }
}
