import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/patient.dart';
import '../../../data/repositories/patient_repository.dart';
import '../../../routes/app_routes.dart';

class PatientsController extends GetxController {
  final PatientRepository _patientRepository = Get.find<PatientRepository>();

  final searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final RxString selectedStatusFilter = 'All'.obs;

  final RxList<Patient> allPatients = <Patient>[].obs;
  final RxList<Patient> filteredPatients = <Patient>[].obs;

  final Rx<ViewState> viewState = ViewState.initial.obs;
  final RxString errorMessage = ''.obs;

  final List<String> statusFilterOptions = ['All', 'Active', 'Inactive', 'Critical'];

  @override
  void onInit() {
    super.onInit();
    loadPatients();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> loadPatients() async {
    viewState.value = ViewState.loading;
    errorMessage.value = '';

    try {
      final list = await _patientRepository.getPatients();
      allPatients.assignAll(list);
      _applyFilters();
    } catch (e) {
      viewState.value = ViewState.error;
      errorMessage.value = 'Failed to load patient records: ${e.toString()}';
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    _applyFilters();
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    _applyFilters();
  }

  void setStatusFilter(String filter) {
    selectedStatusFilter.value = filter;
    _applyFilters();
  }

  void _applyFilters() {
    List<Patient> result = List.from(allPatients);

    // Apply status filter
    if (selectedStatusFilter.value != 'All') {
      result = result.where((p) => p.status.toLowerCase() == selectedStatusFilter.value.toLowerCase()).toList();
    }

    // Apply search query
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isNotEmpty) {
      result = result.where((p) {
        return p.fullName.toLowerCase().contains(q) ||
            p.id.toLowerCase().contains(q) ||
            p.phone.contains(q) ||
            p.email.toLowerCase().contains(q) ||
            p.primaryCarePhysician.toLowerCase().contains(q);
      }).toList();
    }

    filteredPatients.assignAll(result);

    if (result.isEmpty) {
      viewState.value = ViewState.empty;
    } else {
      viewState.value = ViewState.success;
    }
  }

  void navigateToProfile(String patientId) {
    Get.toNamed(
      AppRoutes.patientProfile,
      arguments: {'id': patientId},
    );
  }

  void navigateToAddPatient() {
    Get.toNamed(AppRoutes.registration);
  }
}
