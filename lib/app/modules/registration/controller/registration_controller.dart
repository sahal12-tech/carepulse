import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/patient.dart';
import '../../../data/repositories/patient_repository.dart';
import '../../../routes/app_routes.dart';

class RegistrationController extends GetxController {
  final PatientRepository _patientRepository = Get.find<PatientRepository>();

  final Rx<ViewState> viewState = ViewState.initial.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isSubmitting = false.obs;

  // Form fields for each step
  final RxString firstName = ''.obs;
  final RxString lastName = ''.obs;
  final RxString dateOfBirth = ''.obs;
  final RxString gender = ''.obs;
  final RxString phone = ''.obs;
  final RxString email = ''.obs;
  final RxString insuranceProvider = ''.obs;
  final RxString insuranceNumber = ''.obs;
  final RxList<String> allergies = <String>[].obs;
  final RxList<String> currentMedications = <String>[].obs;
  final RxString emergencyContactName = ''.obs;
  final RxString emergencyContactPhone = ''.obs;
  final RxString primaryCarePhysician = ''.obs;
  final RxString bloodType = 'A+'.obs;
  final RxBool consentGiven = false.obs;

  // Text controllers: created once and kept in sync with the Rx fields
  late final TextEditingController firstNameTextController;
  late final TextEditingController lastNameTextController;
  late final TextEditingController dateOfBirthTextController;
  late final TextEditingController phoneTextController;
  late final TextEditingController emailTextController;
  late final TextEditingController insuranceNumberTextController;

  TextEditingController _bind(RxString rx) {
    final c = TextEditingController(text: rx.value);
    c.addListener(() => rx.value = c.text);
    return c;
  }

  @override
  void onInit() {
    super.onInit();
    // Create text controllers BEFORE clearForm, because clearForm uses them
    firstNameTextController = _bind(firstName);
    lastNameTextController = _bind(lastName);
    dateOfBirthTextController = _bind(dateOfBirth);
    phoneTextController = _bind(phone);
    emailTextController = _bind(email);
    insuranceNumberTextController = _bind(insuranceNumber);
    clearForm();
  }

  @override
  void onClose() {
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    dateOfBirthTextController.dispose();
    phoneTextController.dispose();
    emailTextController.dispose();
    insuranceNumberTextController.dispose();
    super.onClose();
  }

  void clearForm() {
    firstName.value = '';
    lastName.value = '';
    dateOfBirth.value = '';
    gender.value = '';
    phone.value = '';
    email.value = '';
    insuranceProvider.value = '';
    insuranceNumber.value = '';
    allergies.value = [];
    currentMedications.value = [];
    emergencyContactName.value = '';
    emergencyContactPhone.value = '';
    primaryCarePhysician.value = '';
    bloodType.value = 'A+';
    consentGiven.value = false;

    // Clear the visible text too, otherwise the fields keep old text
    firstNameTextController.clear();
    lastNameTextController.clear();
    dateOfBirthTextController.clear();
    phoneTextController.clear();
    emailTextController.clear();
    insuranceNumberTextController.clear();
  }

  Future<void> submitRegistration() async {
    if (!_validateForm()) return;

    isSubmitting.value = true;
    viewState.value = ViewState.loading;
    errorMessage.value = '';

    try {
      // Parse date of birth
      DateTime dob;
      try {
        final parts = dateOfBirth.value.split('/');
        if (parts.length == 3) {
          dob = DateTime(
            int.parse(parts[2]),
            int.parse(parts[0]),
            int.parse(parts[1]),
          );
        } else {
          throw Exception('Invalid date format');
        }
      } catch (e) {
        viewState.value = ViewState.error;
        errorMessage.value =
        'Invalid date of birth format. Please use MM/DD/YYYY';
        isSubmitting.value = false;
        return;
      }

      final patient = Patient(
        firstName: firstName.value,
        lastName: lastName.value,
        dateOfBirth: dob,
        gender: gender.value.isEmpty ? 'Unspecified' : gender.value,
        phone: phone.value,
        email: email.value,
        insuranceProvider: insuranceProvider.value,
        insuranceNumber: insuranceNumber.value,
        allergies: allergies.value,
        currentMedications: currentMedications.value,
        emergencyContactName: emergencyContactName.value,
        emergencyContactPhone: emergencyContactPhone.value,
        primaryCarePhysician: primaryCarePhysician.value,
        bloodType: bloodType.value,
        status: 'Active',
        id: '',
      );

      // result was unused, so the variable is removed
      await _patientRepository.createPatient(patient);

      viewState.value = ViewState.success;
      isSubmitting.value = false;

      // Clear form after successful submission
      clearForm();

      // Show success and navigate to patient directory
      Get.snackbar(
        'Success',
        'Patient registered successfully!',
        backgroundColor: AppColors.accent.withValues(alpha: 0.9),
        colorText: AppColors.onAccent,
      );

      Get.toNamed(AppRoutes.patients);
    } catch (e) {
      viewState.value = ViewState.error;
      errorMessage.value = 'Failed to register patient: ${e.toString()}';
      isSubmitting.value = false;
    }
  }

  bool _validateForm() {
    // Step 1: Personal Information
    if (firstName.value.isEmpty) {
      errorMessage.value = 'First name is required';
      return false;
    }
    if (lastName.value.isEmpty) {
      errorMessage.value = 'Last name is required';
      return false;
    }
    if (dateOfBirth.value.isEmpty) {
      errorMessage.value = 'Date of birth is required';
      return false;
    }
    if (gender.value.isEmpty) {
      errorMessage.value = 'Gender is required';
      return false;
    }

    // Step 2: Contact Information
    if (phone.value.isEmpty) {
      errorMessage.value = 'Phone number is required';
      return false;
    }
    if (email.value.isEmpty) {
      errorMessage.value = 'Email is required';
      return false;
    }
    // Simple email validation
    if (!email.value.contains('@') || !email.value.contains('.')) {
      errorMessage.value = 'Please enter a valid email address';
      return false;
    }

    // Step 3: Insurance Details
    if (insuranceProvider.value.isEmpty) {
      errorMessage.value = 'Insurance provider is required';
      return false;
    }
    if (insuranceNumber.value.isEmpty) {
      errorMessage.value = 'Insurance number is required';
      return false;
    }

    // Step 5: Consent
    if (!consentGiven.value) {
      errorMessage.value = 'You must give consent to proceed';
      return false;
    }

    return true;
  }
}