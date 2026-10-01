# Appointments Screen Rules

## Layout Override
- **Layout:** Tabbed interface (Day, Week, Month) with schedule grid and side panel for doctor availability
- **Views:** 
  - Day: Hourly grid (typically 7am-7pm) with ability to scroll hours
  - Week: Weekly calendar with all-day events and hourly slots
  - Month: Monthly view with event dots on dates
- **Side Panel:** Doctor availability (list of doctors with status: available, busy, offline)

## Specific Guidelines
- **Status Flow:** 
  - Use color-coded dots or status tags: Confirmed (blue), In Progress (yellow), Completed (green), No-show (gray)
  - Always show icon + text for status (never color alone)
- **Doctor Availability:** 
  - Show doctor name, specialty, and status indicator (circle with label)
  - Allow tapping to filter schedule by doctor
- **Interaction:** 
  - Tap on slot to see details or book/edit appointment
  - Long press for quick actions (cancel, reschedule, check-in)
  - Drag and drop to reschedule (if enabled)
- **Empty State:** Show message when no appointments in selected view
- **Loading State:** Show skeleton loader for schedule grid
- **Error State:** Show error message and retry button
- **Accessibility:** 
  - Ensure touch targets are at least 48dp
  - Provide alternative views for users who cannot use drag and drop
  - Label all interactive elements
- **Navigation:** 
  - Today button to jump to current date
  - Date picker for jumping to any date

## Components Used
- TabBar (Day, Week, Month)
- ScheduleGrid (custom, different for each view)
- DoctorAvailabilityList
- AppointmentCard (for displaying appointment in slot)
- StatusBadge (with icon and text)
- TodayButton
- DatePicker
- LoadingIndicator
- EmptyStateIndicator

## Notes
- This screen overrides the MASTER.md pattern to focus on appointment scheduling.
- All other rules from MASTER.md apply.
