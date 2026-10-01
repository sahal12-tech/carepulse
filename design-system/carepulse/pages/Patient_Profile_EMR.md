# Patient Profile/EMR Screen Rules

## Layout Override
- **Layout:** Single scrollable view with sticky header for patient name and critical info
- **Sections:** 
  1. Critical Banner (allergies, critical conditions) - always visible under app bar
  2. Demographics (read-only, with edit button)
  3. Timeline (visits, prescriptions, labs, notes) - grouped by date
  4. Quick Actions (add prescription, add lab request, schedule follow-up)

## Specific Guidelines
- **Critical Banner:** 
  - Background color: --color-destructive (red) with white text for allergies
  - Use icon + text for each allergy/critical condition
  - Always visible, not scrollable out of view
- **Demographics:** 
  - Display in grid (two columns: label and value)
  - Edit button navigates to edit screen
- **Timeline:**
  - Group by date (today, yesterday, last 7 days, older)
  - Each entry type has an icon and color-coded dot (prescription: blue, lab: green, note: gray)
  - Tap to expand for details
- **Progress Notes:** 
  - Rich text display (if formatted) or plain text
  - Add new note button at bottom
- **Accessibility:** 
  - Ensure critical banner has sufficient contrast
  - All interactive elements have labels
  - Timeline is navigable by screen reader (use semantic labels)
- **States:** 
  - Loading skeletons for each section
  - Empty state for sections with no data (e.g., no prescriptions)
  - Error state for failed load (with retry)

## Components Used
- AppBar (with patient name and ID)
- CriticalBanner (custom widget)
- InfoGrid (for demographics)
- TimelineView (custom, expandable sections)
- ProgressNoteList
- ActionButtons (FloatingActionButton or bottom bar)
- LoadingIndicator
- EmptyStateIndicator

## Notes
- This screen may require a custom scroll view to keep the critical banner visible.
- All other rules from MASTER.md apply.
