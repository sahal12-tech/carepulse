import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../controller/dashboard_controller.dart';
import '../widgets/appointment_tile.dart';
import '../widgets/metric_card.dart';
import '../widgets/quick_action_card.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.local_hospital, color: AppColors.primary),
            const SizedBox(width: AppConstants.spaceSm),
            Text(
              AppConstants.appName,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            onPressed: controller.logout,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.loadDashboardData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppConstants.spaceMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Banner
              Card(
                color: AppColors.primary,
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.spaceLg),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: Icon(
                          controller.currentRole.icon,
                          size: 32,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: AppConstants.spaceMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back, ${controller.currentUsername}',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.spaceSm,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(
                                    AppConstants.radiusSm),
                              ),
                              child: Text(
                                controller.currentRole.displayName,
                                style: TextStyle(
                                  color: theme.colorScheme.onPrimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spaceLg),

              // Metrics Section
              Text(
                'Today\'s Overview',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: AppConstants.spaceSm),
              Obx(() {
                final totalPatients = controller.totalPatientsCount.value;
                final todayAppointments = controller.todayAppointmentsCount.value;
                final inProgress = controller.inProgressCount.value;
                final completed = controller.completedCount.value;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 600;
                    final crossAxisCount = isWide ? 4 : 2;

                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      mainAxisExtent: isWide ? 150 : 160,
                      crossAxisSpacing: AppConstants.spaceMd,
                      mainAxisSpacing: AppConstants.spaceMd,
                      children: [
                        MetricCard(
                          title: 'Total Patients',
                          value: '$totalPatients',
                          icon: Icons.people_alt_outlined,
                          iconColor: AppColors.primary,
                          subtitle: 'Registered in system',
                        ),
                        MetricCard(
                          title: 'Appointments',
                          value: '$todayAppointments',
                          icon: Icons.calendar_today_outlined,
                          iconColor: AppColors.secondary,
                          subtitle: 'Scheduled for today',
                        ),
                        MetricCard(
                          title: 'In Progress',
                          value: '$inProgress',
                          icon: Icons.pending_actions,
                          iconColor: AppColors.primary,
                          subtitle: 'Currently in room',
                        ),
                        MetricCard(
                          title: 'Completed',
                          value: '$completed',
                          icon: Icons.check_circle_outline,
                          iconColor: AppColors.accent,
                          subtitle: 'Visits concluded',
                        ),
                      ],
                    );
                  },
                );
              }),
              //const SizedBox(height: AppConstants.spaceSm),

              // Quick Actions
              Text(
                'Quick Actions',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: AppConstants.spaceSm),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 700;
                  return isWide
                      ? Row(
                          children: [
                            Expanded(
                              child: QuickActionCard(
                                title: 'Add New Patient',
                                description:
                                    'Register demographic and medical details',
                                icon: Icons.person_add_alt_1_outlined,
                                backgroundColor: AppColors.primary,
                                onTap: controller.navigateToAddPatient,
                              ),
                            ),
                            const SizedBox(width: AppConstants.spaceMd),
                            Expanded(
                              child: QuickActionCard(
                                title: 'Book Appointment',
                                description:
                                    'Schedule new patient consultation',
                                icon: Icons.event_available_outlined,
                                backgroundColor: AppColors.accent,
                                onTap: controller.navigateToAppointments,
                              ),
                            ),
                            const SizedBox(width: AppConstants.spaceMd),
                            Expanded(
                              child: QuickActionCard(
                                title: 'Patient Directory',
                                description:
                                    'Search and filter clinical records',
                                icon: Icons.folder_shared_outlined,
                                backgroundColor: AppColors.secondary,
                                onTap: controller.navigateToPatientDirectory,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            QuickActionCard(
                              title: 'Add New Patient',
                              description:
                                  'Register demographic and medical details',
                              icon: Icons.person_add_alt_1_outlined,
                              backgroundColor: AppColors.primary,
                              onTap: controller.navigateToAddPatient,
                            ),
                            const SizedBox(height: AppConstants.spaceSm),
                            QuickActionCard(
                              title: 'Book Appointment',
                              description: 'Schedule new patient consultation',
                              icon: Icons.event_available_outlined,
                              backgroundColor: AppColors.accent,
                              onTap: controller.navigateToAppointments,
                            ),
                            const SizedBox(height: AppConstants.spaceSm),
                            QuickActionCard(
                              title: 'Patient Directory',
                              description: 'Search and filter clinical records',
                              icon: Icons.folder_shared_outlined,
                              backgroundColor: AppColors.secondary,
                              onTap: controller.navigateToPatientDirectory,
                            ),
                          ],
                        );
                },
              ),
              const SizedBox(height: AppConstants.spaceLg),

              // Today's Appointments List
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today\'s Appointments',
                    style: theme.textTheme.titleLarge,
                  ),
                  TextButton.icon(
                    onPressed: controller.navigateToAppointments,
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    label: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spaceSm),

              Obx(() {
                switch (controller.viewState.value) {
                  case ViewState.loading:
                    return const SizedBox(
                      height: 200,
                      child:
                          LoadingView(message: 'Fetching today\'s schedule...'),
                    );
                  case ViewState.error:
                    return ErrorStateView(
                      message: controller.errorMessage.value,
                      onRetry: controller.loadDashboardData,
                    );
                  case ViewState.empty:
                    return EmptyStateView(
                      icon: Icons.event_busy,
                      title: 'No Appointments Today',
                      message: 'There are no scheduled appointments for today.',
                      actionLabel: 'Schedule Appointment',
                      onActionPressed: controller.navigateToAppointments,
                    );
                  case ViewState.initial:
                  case ViewState.success:
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.todayAppointments.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppConstants.spaceSm),
                      itemBuilder: (context, index) {
                        final apt = controller.todayAppointments[index];
                        return AppointmentTile(
                          appointment: apt,
                          onStatusChanged: (newStatus) => controller
                              .updateAppointmentStatus(apt.id, newStatus),
                        );
                      },
                    );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}