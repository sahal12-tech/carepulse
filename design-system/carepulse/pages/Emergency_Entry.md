# Emergency Entry Screen Rules

## Layout Override
- **Layout:** Simple form with minimal fields for rapid entry
- **Fields:** 
  1. Patient Name (required)
  2. Age/DOB (required)
  3. Gender (optional)
  4. Emergency Contact (phone, required)
  5. Chief Complaint (text area, required)
  6. Allergies (known, optional)
  7. Current Medications (optional)
  8. Vital Signs (optional: BP, HR, RR, SpO2, Temp)

## Specific Guidelines
- **Prioritization:** 
  - Most critical fields at top (name, age, emergency contact, chief complaint)
  - Use large touch targets (minimum 48dp)
  - Avoid scrolling if possible; fit on screen without scroll
- **Input Methods:** 
  - Use text fields for name and complaint
  - Use dropdowns for standard options (gender, blood type if needed)
  - Use quick select for common allergies/medications (if applicable)
- **Validation:** 
  - Required fields must be filled before submit
  - Show inline errors immediately (as user types) or on submit attempt
  - Use semantic color for errors (--color-destructive) with icon
- **Submit Button:** 
  - Prominent primary button: "Save Emergency Entry"
  - Always enabled when form is valid
  - Show loading state on submit
- **Critical Info Banner:** 
  - Option to flag as critical (e.g., unconscious, chest pain) with visual indicator
  - Use --color-destructive background with white text and icon
- **Accessibility:** 
  - Ensure all fields are accessible
  - Provide voice input option for chief complaint (if possible)
  - Announce errors and success messages
- **States:** 
  - Loading: show spinner on submit button
  - Success: show confirmation message and option to clear for next entry
  - Error: show error summary and highlight fields
  - Empty: not applicable

## Components Used
- AppBar (with title "Emergency Entry")
- TextField (for name, complaint)
- Dropdown (for gender, etc.)
- CriticalInfoBanner (custom, for flagging critical status)
- VitalSignsInput (custom group of fields)
- ElevatedButton (primary)
- LoadingIndicator (on button)
- SnackBar (for success/error)

## Notes
- This screen overrides the MASTER.md pattern to focus on rapid entry form.
- All other rules from MASTER.md apply.
