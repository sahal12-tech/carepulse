# CarePulse Architecture

## Overview

CarePulse is a Flutter patient-management application using:

- **Flutter Material 3** for the UI.
- **GetX** for routing, dependency injection, and reactive state management.
- **Feature-first modules** for application organization.
- **Repository interfaces with mock implementations** for the current data layer.
- **Design tokens** derived from `design-system/carepulse/MASTER.md`.

The active application is primarily implemented under `lib/app`.

## Project structure

```text
lib/
├── main.dart
├── app/
│   ├── core/
│   │   ├── constants/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── widgets/
│   ├── data/
│   │   ├── api/
│   │   ├── models/
│   │   └── repositories/
│   ├── modules/
│   │   ├── auth/
│   │   ├── dashboard/
│   │   ├── patients/
│   │   ├── patient_profile/
│   │   ├── appointments/
│   │   └── registration/
│   └── routes/
├── screens/
├── models/
├── themes/
├── utils/
└── components/
```

The active application path is:

```text
lib/main.dart
  → lib/app/routes
  → lib/app/modules
  → lib/app/data
  → lib/app/core
```

## Application startup

`lib/main.dart` creates a `GetMaterialApp` called `CarePulseApp`.

It:

- Uses Material 3.
- Loads light and dark themes.
- Uses the system theme mode.
- Starts at `AppRoutes.login`.
- Registers routes from `AppPages.routes`.
- Disables the debug banner.

```text
main.dart
  └── CarePulseApp
      └── GetMaterialApp
          ├── AppTheme.lightTheme
          ├── AppTheme.darkTheme
          ├── initialRoute: /login
          └── AppPages.routes
```

There is no global application binding. Dependencies are registered by individual route bindings.

## Routing and dependency injection

Routing is defined in:

- `lib/app/routes/app_routes.dart`
- `lib/app/routes/app_pages.dart`

Current routes:

| Route | View | Binding |
|---|---|---|
| `/login` | `LoginView` | `AuthBinding` |
| `/dashboard` | `DashboardView` | `DashboardBinding` |
| `/patients` | `PatientDirectoryView` | `PatientsBinding` |
| `/patient-profile` | `PatientProfileView` | `PatientProfileBinding` |
| `/appointments` | `AppointmentsView` | `AppointmentsBinding` |
| `/registration` | `RegistrationView` | `RegistrationBinding` |

Each `GetPage` associates a view with a binding. Bindings use `Get.lazyPut` to register repositories and controllers.

```text
GetPage('/patients')
  └── PatientsBinding
      ├── PatientRepository → MockPatientRepository
      └── PatientsController

PatientDirectoryView
  └── GetView<PatientsController>
      └── Get.find<PatientsController>()
```

Controllers obtain dependencies directly using `Get.find<T>()`.

There is no route middleware or centralized authentication guard. The login screen is the initial route, but other routes are not protected by a centralized authorization mechanism.

## State management

Controllers extend `GetxController` and hold reactive state using GetX observables:

- `RxBool`
- `RxString`
- `RxInt`
- `RxList<T>`
- `Rx<ViewState>`

The shared `ViewState` enum in `app_constants.dart` contains:

```text
initial
loading
success
empty
error
```

Views use `Obx` to rebuild when controller state changes.

Typical flow:

```text
User interaction
  └── View callback
      └── Controller method
          └── Repository call
              └── Controller updates Rx state
                  └── Obx rebuilds the UI
```

For example, patient search works as follows:

```text
TextField.onChanged
  └── PatientsController.onSearchChanged()
      └── Apply local status/search filters
          └── filteredPatients.assignAll(...)
              └── Patient directory UI rebuilds
```

Controllers generally dispose of their `TextEditingController` instances in `onClose`.

## Feature modules

### Authentication

Located under `lib/app/modules/auth`.

`LoginView` renders the login form. `AuthController` manages:

- Username and password fields.
- Selected user role.
- Password visibility.
- Login loading and error state.

`AuthRepository` abstracts login and logout. `MockAuthRepository` accepts any non-empty username and password and stores authentication state in memory.

Successful login navigates with:

```dart
Get.offAllNamed(AppRoutes.dashboard);
```

There is currently no token storage, session restoration, or backend authentication.

### Dashboard

Located under `lib/app/modules/dashboard`.

`DashboardController` loads data from:

- `AppointmentRepository`
- `PatientRepository`
- `AuthRepository`

It derives:

- Total patient count.
- Today’s appointment count.
- In-progress appointment count.
- Completed appointment count.
- Current username and role.

The dashboard contains:

- Welcome banner.
- Metric cards.
- Quick action cards.
- Today’s appointments.
- Appointment status actions.
- Logout action.

The layout adapts at approximately `600px` and `700px` breakpoints for metric grids and quick actions.

### Patient directory

Located under `lib/app/modules/patients`.

`PatientsController` owns:

- Complete patient list.
- Filtered patient list.
- Search query.
- Selected status filter.
- Loading, empty, and error states.

The directory uses two responsive layouts:

```text
Width < 600px
  └── PatientCard list

Width >= 600px
  └── PatientTable / DataTable
```

Selecting a patient navigates with a GetX argument:

```dart
Get.toNamed(
  AppRoutes.patientProfile,
  arguments: {'id': patientId},
);
```

### Patient profile

Located under `lib/app/modules/patient_profile`.

`PatientProfileController`:

1. Reads the patient ID from `Get.arguments`.
2. Falls back to `Get.parameters['id']` when available.
3. Falls back to `P-1001` when no ID is supplied.
4. Loads the patient from `PatientRepository`.
5. Loads appointments from `AppointmentRepository`.
6. Filters appointments into the patient’s visit history.

The profile view is composed from:

- Critical/allergy banner.
- Demographics card.
- Medical summary.
- Clinical visit timeline.

The demographics edit action is currently a UI placeholder that displays a snackbar rather than persisting changes.

### Appointments

Located under `lib/app/modules/appointments`.

`AppointmentsController` manages:

- Selected date.
- Status filter.
- All appointments.
- Filtered appointments.
- Patient list for booking.
- Appointment status updates.
- New appointment creation.

The view provides:

- Previous/next date navigation.
- Date picker.
- Status filter chips.
- Appointment cards.
- Booking dialog.
- Start, complete, and no-show actions.

`BookingDialog` owns temporary form state locally, then calls `AppointmentsController.bookNewAppointment()`.

Some appointment widgets exist but are not currently connected to the active view:

- `AppointmentScheduleGrid`
- `DoctorAvailabilityPanel`

### Registration

Located under `lib/app/modules/registration`.

The registration flow uses five steps:

1. Personal information.
2. Contact information.
3. Insurance details.
4. Medical history.
5. Consent and submission.

`RegistrationStepper` owns the current step locally as a `StatefulWidget` field. The form data itself is held in `RegistrationController` using reactive fields.

The controller maintains synchronized text controllers and performs final validation before constructing a `Patient` model and calling:

```dart
PatientRepository.createPatient(...)
```

On success, it navigates to the patient directory.

## Data layer

### Models

The primary models are:

- `Patient`
- `Appointment`
- `Doctor`

They provide:

- Immutable fields.
- `fromJson` factories.
- `toJson` methods.
- Derived display properties.
- `Appointment.copyWith` for status and appointment updates.

Several domain concepts currently use plain strings rather than enums, including:

- Patient status.
- Appointment status.
- Appointment type.
- Gender.

### Repositories

Repositories are defined as abstract interfaces with mock implementations in the same files:

- `AuthRepository` / `MockAuthRepository`
- `PatientRepository` / `MockPatientRepository`
- `AppointmentRepository` / `MockAppointmentRepository`

The mock repositories:

- Store data in mutable in-memory lists.
- Simulate network latency with `Future.delayed`.
- Implement basic CRUD and filtering behavior.
- Are intended to be replaced with backend implementations.

There is no service or use-case layer between controllers and repositories. Controllers call repository methods directly.

### API layer

`lib/app/data/api/api_client.dart` is intentionally a stub with:

```text
baseUrl = http://localhost:8000/api/v1
```

It contains TODOs for:

- HTTP client implementation.
- Authentication token interceptors.
- Error handling.
- Response parsing.

The `http` dependency is present in `pubspec.yaml`, but the active application currently uses mock repositories.

`API_ENDPOINTS.md` documents the intended FastAPI endpoints for authentication, patients, appointments, doctors, dashboard data, and emergency cases.

## Shared core and design system

Shared infrastructure is under `lib/app/core`.

### Theme and tokens

The theme is split into:

- `app_theme.dart`
- `light_theme.dart`
- `dark_theme.dart`

Design tokens are centralized in:

- `AppColors`
- `AppConstants`

These cover:

- Color palette.
- Typography.
- Spacing.
- Border radii.
- Minimum touch target.
- Status colors.
- User roles.

The values correspond to `design-system/carepulse/MASTER.md`, including the Atkinson Hyperlegible font family, an 8dp spacing rhythm, and responsive/accessibility guidance.

### Shared widgets

Reusable state and status widgets include:

- `LoadingView`
- `EmptyStateView`
- `ErrorStateView`
- `StatusBadge`

These are used throughout the feature views to keep loading, empty, error, and status rendering consistent.

## Architectural observations

### Strengths

- Clear feature-oriented module organization.
- Consistent GetX route/binding/controller/view pattern.
- Repository interfaces make mock-to-API replacement feasible.
- Shared design tokens are centralized.
- Responsive patient directory layout is implemented.
- Controllers manage loading, empty, success, and error states.
- Most controller-owned text controllers are disposed correctly.

### Current boundaries and limitations

- Backend integration has not been implemented.
- There is no centralized authentication guard or session persistence.
- Controllers communicate directly with repositories; there are no use cases or domain services.
- Mock repository instances are registered through route bindings rather than a single application-wide data layer.
- Appointment doctors and availability are partly hardcoded in UI widgets.
- Several status and type values are raw strings.
- Patient editing is not implemented.
- Emergency entry is documented in the API specification but is not part of the active route table.

### Duplicate or legacy structure

The active route graph does not use most of the older top-level folders:

- `lib/screens/` contains placeholder screen classes.
- `lib/themes/`, `lib/models/`, and `lib/utils/` mostly re-export files from `lib/app`.
- `lib/components/custom/` contains older or unused components.
- `profile_controller.dart` and `profile_binding.dart` are compatibility exports for the newer patient profile files.

The active architecture should therefore be understood through `lib/app`, while the other directories represent compatibility, legacy, or unfinished prototype code.

## Testing

The repository currently contains a small widget smoke test in `test/widget_test.dart`. It pumps `CarePulseApp` and verifies that the CarePulse branding is rendered. There are no dedicated controller, repository, routing, or integration test suites in the inspected project.
