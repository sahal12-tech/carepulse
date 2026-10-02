# CarePulse Phase 2 Audit Report

## Phase 1 Verification
✅ **Phase 1 components verified as still functional:**
- Theme: Colors, typography, spacing from MASTER.md via AppColors/AppConstants
- Routes: All routes defined in AppRoutes including login, dashboard, patients, patientProfile, appointments, registration
- Bindings: AuthBinding, DashboardBinding, PatientsBinding properly dependency inject repositories
- Models: Patient, Doctor, Appointment models with proper fields and JSON serialization
- Mock Repositories: PatientRepository, AuthRepository, AppointmentRepository with Mock implementations
- Login: LoginView with form validation, role selection, secure password handling
- Dashboard: DashboardView with metrics, quick actions, appointment list, proper state handling

## Phase 2 Audit

### Patient Directory ✅ MOSTLY COMPLETE
| Item | Status | Details |
|------|--------|---------|
| Search box | ✅ DONE | TextField with controller, onChanged, clear button, search functionality in controller |
| Status filter | ✅ DONE | FilterChip options ('All', 'Active', 'Inactive', 'Critical'), controller state management |
| Adaptive layout (cards on phone, table on tablet) | ✅ DONE | LayoutBuilder with breakpoint at 600px, PatientCard for phone, PatientTable for tablet/desktop |
| Status badges with icon + text | ✅ DONE | StatusBadge widget used in both PatientCard and PatientTable, shows icon + text |
| Loading / empty / error states | ✅ DONE | LoadingView, ErrorStateView, EmptyStateView properly wired to controller ViewState |
| Controller + binding + route wired to mock PatientRepository | ✅ DONE | PatientsController, PatientsBinding, route in AppPages, MockPatientRepository with sample data |

### Patient Profile △ INCOMPLETE
| Item | Status | Details |
|------|--------|---------|
| Allergy/critical banner | △ PARTIAL | CriticalBanner widget exists (`lib/app/modules/patient_profile/widgets/critical_banner.dart`) but not yet integrated into a profile view |
| Demographics section | ❌ MISSING | No implementation found for read-only demographics display with edit button |
| Visit timeline | ❌ MISSING | No implementation found for grouped timeline view (visits, prescriptions, labs, notes) |
| Navigation from directory to profile | △ PARTIAL | Navigation exists: PatientCard/Table call `controller.navigateToProfile(patient.id)`, route `/patient-profile` defined, but target screen is placeholder |
| Loading / error state | ❌ MISSING | No profile view implementation to handle states |

## Issues Found

### Files with TODOs (from previous session)
- `lib/app/data/api/api_client.dart`: 
  - TODO: Add http/dio client implementation when connecting to FastAPI backend
  - TODO: Add request interceptors for Auth tokens
  - TODO: Add error handling and response parsing wrappers

### Files with Hard-coded Values (Violating Design System)
*Note: Some hard-coded values (icon sizes, specific dimensions) may be acceptable for UI specificity, but colors, spacing, and radii should come from theme tokens.*

#### patient_card.dart
- Line 75: `color: Colors.grey` (should be from theme/colors)
- Line 75: `size: 14` (hard-coded icon size)
- Line 82: `color: Colors.grey` (should be from theme/colors)
- Line 82: `size: 14` (hard-coded icon size)
- Line 111: `size: 12` (hard-coded icon size)

#### patient_table.dart
- Line 57: `size: 16` (hard-coded icon size)

#### critical_banner.dart
- Line 30: `width: 1.5` (hard-coded border width)
- Line 44: `color: Colors.white` (should be from theme/colors - use `Colors.white` only if it's a literal white requirement, otherwise use theme)
- Line 45: `size: 20` (hard-coded icon size)

#### dashboard_view.dart (modified file)
- Line 23: `elevation: 4` (hard-coded elevation)
- Line 61: `size: 32` (hard-coded icon size)
- Line 75: `color: Colors.white` (should use `theme.colorScheme.onSurface` or similar)
- Line 86: `color: Colors.white.withValues(alpha: 0.2)` (should use theme colors)
- Line 93: `color: Colors.white` (should use theme colors)
- Line 94: `fontSize: 12` (hard-coded, should use text theme)
- Line 192: `minimumSize: const Size.fromHeight(50)` (close to minTouchTarget 48, but hard-coded)
- Line 199: `strokeWidth: 2.5` (hard-coded)
- Line 203: `height: 24, width: 24` (hard-coded loading indicator size)
- Line 206: `fontSize: 16` (hard-coded)
- Line 207: `fontWeight: FontWeight.bold` (hard-coded weight)

## Fix Plan for Phase 2 Completion

### 1. Complete Patient Profile Implementation
Create the following files:
- `lib/app/modules/patient_profile/view/patient_profile_view.dart` - Main profile view with adaptive layout
- `lib/app/modules/patient_profile/controller/profile_controller.dart` - Controller for profile data loading/state
- `lib/app/modules/patient_profile/binding/profile_binding.dart` - Bind dependencies
- `lib/app/modules/patient_profile/widgets/demographics_section.dart` - Read-only demographics with edit button
- `lib/app/modules/patient_profile/widgets/timeline_view.dart` - Grouped timeline (visits, prescriptions, labs, notes)
- Update `lib/app/modules/patient_profile/widgets/critical_banner.dart` to fix hard-coded colors/sizes

### 2. Fix Hard-coded Values
Update the identified files to use theme tokens:
- Replace hard-coded colors with `AppColors` or `theme.colorScheme`
- Replace hard-coded spacing with `AppConstants`
- Replace hard-coded icon sizes with semantic constants where appropriate
- Replace hard-coded text styles with theme text themes
- Ensure all radii use `AppConstants.radius*`

### 3. Verify Navigation and State Management
- Ensure patient profile navigation passes patient ID correctly
- Implement proper loading/error/empty states in profile controller
- Connect profile controller to MockPatientRepository (use existing `getPatientById` method)

### 4. Run Validation
- `flutter analyze` must be clean
- `flutter run -d chrome` should launch without errors
- Verify Pre-Delivery Checklist from design-system/carepulse/pre-rules.md for directory and profile screens

### 5. Update Design System Documentation
- Create `design-system/carepulse/pages/Patient Profile.md` if specific overrides needed
- Ensure all colors, fonts, spacing come from MASTER.md via theme

## Estimated Effort
- Patient Profile View: 2-3 hours
- Demographics Section: 1-2 hours  
- Timeline View: 2-3 hours
- Critical Banner fixes: 30 minutes
- Hard-coded value fixes across files: 1 hour
- Testing and validation: 1-2 hours