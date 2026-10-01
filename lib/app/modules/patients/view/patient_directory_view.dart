import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../controller/patients_controller.dart';
import '../widgets/patient_card.dart';
import '../widgets/patient_table.dart';

class PatientDirectoryView extends GetView<PatientsController> {
  const PatientDirectoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Directory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_outlined),
            tooltip: 'Register Patient',
            onPressed: controller.navigateToAddPatient,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.loadPatients,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spaceMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Input
              Obx(
                () => TextField(
                  controller: controller.searchController,
                  onChanged: controller.onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search by name, ID, phone, or email...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: controller.clearSearch,
                            tooltip: 'Clear search',
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spaceMd),

              // Status Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: controller.statusFilterOptions.map((filter) {
                      final isSelected = controller.selectedStatusFilter.value == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: AppConstants.spaceSm),
                        child: FilterChip(
                          label: Text(filter),
                          selected: isSelected,
                          onSelected: (_) => controller.setStatusFilter(filter),
                          selectedColor: theme.colorScheme.primary.withValues(alpha: 0.2),
                          checkmarkColor: theme.colorScheme.primary,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spaceMd),

              // Content Area
              Expanded(
                child: Obx(() {
                  switch (controller.viewState.value) {
                    case ViewState.loading:
                      return const LoadingView(
                        message: 'Searching patient database...',
                      );
                    case ViewState.error:
                      return ErrorStateView(
                        message: controller.errorMessage.value,
                        onRetry: controller.loadPatients,
                      );
                    case ViewState.empty:
                      return EmptyStateView(
                        icon: Icons.search_off_outlined,
                        title: 'No Patients Found',
                        message: 'No patient records match your current search and filter criteria.',
                        actionLabel: 'Register New Patient',
                        onActionPressed: controller.navigateToAddPatient,
                      );
                    case ViewState.initial:
                    case ViewState.success:
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          final isTabletOrDesktop = constraints.maxWidth >= 600;

                          if (isTabletOrDesktop) {
                            return SingleChildScrollView(
                              child: PatientTable(
                                patients: controller.filteredPatients,
                                onSelectPatient: controller.navigateToProfile,
                              ),
                            );
                          }

                          return ListView.separated(
                            itemCount: controller.filteredPatients.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: AppConstants.spaceSm),
                            itemBuilder: (context, index) {
                              final patient = controller.filteredPatients[index];
                              return PatientCard(
                                patient: patient,
                                onTap: () => controller.navigateToProfile(patient.id),
                              );
                            },
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
    );
  }
}
