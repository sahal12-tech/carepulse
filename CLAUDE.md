# CarePulse - Patient Management System

## Project Goal
CarePulse is a clinic Patient Management System built with Flutter (Material 3) + GetX (state, routing, DI). The frontend structure and UI only (no backend) with mock data implementations. The FastAPI backend will be provided separately.

## Stack
- **Framework**: Flutter (Material 3)
- **State Management**: GetX
- **Dependency Injection**: GetX
- **Routing**: GetX
- **UI Components**: Custom widgets following design system
- **Data Layer**: Mock repositories (to be replaced with FastAPI backend)
- **Design System**: Based on `design-system/carepulse/MASTER.md`

## Folder Structure
```
lib/
├── app/
│   ├── core/
│   │   ├── constants/       # App colors, constants, enums
│   │   ├── theme/           # Light/dark themes
│   │   ├── utils/           # Validators
│   │   └── widgets/         # Shared widgets (loading, error, empty states, status badge, etc.)
│   ├── data/
│   │   ├── api/             # API client stub (for FastAPI backend)
│   │   ├── models/          # Data models (Patient, Doctor, Appointment)
│   │   └── repositories/    # Abstract repositories + Mock implementations
│   ├── modules/
│   │   ├── auth/            # Authentication (login)
│   │   ├── dashboard/       # Dashboard view
│   │   ├── patients/        # Patient directory & profile
│   │   └── patient_profile/ # Patient profile (critical banner, demographics, timeline)
│   └── routes/              # App routes and pages
├── main.dart                # Entry point
```

## Rules (from task instructions)
1. **Design System**: All colors, fonts, spacing, radius come from MASTER.md via theme tokens
2. **Controllers**: Hold Rx state + ViewState (loading/success/empty/error); repositories injected in bindings; dispose in onClose
3. **API Layer**: `lib/app/data/api/api_client.dart` stays an empty stub (baseUrl + TODOs) - backend provided separately
4. **Responsive**: Adaptive layout (cards on phone, table on tablet/adaptive)
5. **Accessibility**: 48dp targets, Semantics labels, no overflow at 200% text scale
6. **Screen Rules**: Save screen-specific rules in `design-system/carepulse/pages/<screen>.md` only where they differ from MASTER.md
7. **Validation**: Run `flutter analyze` (must be clean) and `flutter run -d chrome`

## Progress
- **Phase 1**: ✅ COMPLETE
  - Theme from MASTER.md
  - Routes, bindings, models, mock repositories
  - Login, dashboard
- **Phase 2**: ✅ COMPLETE
  - Patient Directory: search box, status filter, adaptive layout (cards/table), status badges, loading/empty/error states, controller+binding+route wired to mock PatientRepository
  - Patient Profile: allergy/critical banner, demographics section, visit timeline placeholder, navigation from directory to profile, loading/error states
- **Phase 3**: 📋 PLANNED
  - Appointments + Registration screens
  - State polish (enhanced error handling, loading states, animations)
  - Integration with FastAPI backend (when available)

## Notes
- Mock data only - no backend integration in this frontend-only implementation
- All UI follows the CarePulse design system from MASTER.md
- GetX used for state management, dependency injection, and routing