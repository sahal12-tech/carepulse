# Dashboard Screen Rules

## Pattern Override
- **Pattern:** Dashboard Layout
- **Sections:** 
  1. Header (with user info and date)
  2. Key Metrics Grid (3-4 cards: Appointments Today, Pending Doctor Reviews, Check-in Status, Quick Actions)
  3. Quick Actions List (Add Patient, Book Appointment, Emergency Entry)
  4. Optional: Today's Appointments List

## Specific Guidelines
- **Layout:** Use responsive grid (2 columns on phone, 3-4 on tablet) for metrics
- **Cards:** Use card component with elevation and hover states
- **Quick Actions:** Use icon + text buttons in a list
- **Data Display:** Use bullet charts for performance metrics (if showing targets) or simple numbers with icons
- **Accessibility:** Ensure each card has a clear heading and is keyboard navigable
- **States:** Loading, empty, error states for data sections

## Components Used
- Card (with variants: metric card, action card)
- Button (icon button for quick actions)
- ListTile (for quick actions list)
- BulletChart (if using charts) or simple text with icon
- Header/AppBar

## Notes
- This screen overrides the MASTER.md pattern to focus on dashboard-specific layout.
- All other rules (colors, typography, spacing, etc.) from MASTER.md apply unless overridden here.
