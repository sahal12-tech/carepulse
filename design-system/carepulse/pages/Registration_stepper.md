# Registration Stepper Screen Rules

## Layout Override
- **Layout:** Vertical stepper with progress indicator at top and form content below
- **Steps:** 
  1. Personal Information
  2. Contact Information
  3. Insurance Details
  4. Medical History
  5. Consent & Submission

## Specific Guidelines
- **Stepper:** 
  - Show step number and title (optional: icon)
  - Highlight current step, disable future steps
  - Allow navigation to previous steps (but not forward until validation passes)
- **Form Validation:** 
  - Validate each step before allowing progression
  - Show inline errors for each field
  - Show error summary at top of failed submission (if any)
  - Use semantic color tokens for error state (--color-destructive) with icon
- **Input Fields:** 
  - Use appropriate input types (text, email, phone, date, select)
  - Show helper text and optional labels
  - Mask sensitive fields (e.g., SSN) if applicable
- **Medical History:** 
  - Use checkboxes for common conditions with "Other" option
  - Allow multiple selections
- **Consent:** 
  - Show required consent text with checkbox
  - Require consent to proceed to submit
- **Submit Button:** 
  - Primary button: "Submit Registration"
  - Show loading state on submit
  - Show success message on completion
- **Accessibility:** 
  - Ensure each step is reachable by keyboard
  - Focus management: move focus to first error on validation failure
  - Announce step changes for screen reader users
- **States:** 
  - Loading: show spinner on submit button
  - Success: show success snackbar or dialog
  - Error: show error summary and highlight fields
  - Empty: not applicable (form always has fields)

## Components Used
- Stepper (custom, with step indicators)
- FormField (with label, input, error text)
- Dropdown (for insurance provider, etc.)
- CheckboxList (for medical history)
- Checkbox (for consent)
- ElevatedButton (primary, disabled state)
- TextButton (for secondary actions like "Clear Form")
- LoadingIndicator (on button)
- SnackBar or AlertDialog (for success/error)

## Notes
- This screen may override the MASTER.md pattern to focus on stepper form layout.
- All other rules from MASTER.md apply.
