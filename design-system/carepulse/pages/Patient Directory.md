# Patient Directory Screen Rules

## Layout Override
- **Layout:** Adaptive list/table
  - Phone: Card layout (one patient per card, vertical scroll)
  - Tablet: Table layout (multiple columns, horizontal scroll if needed)
- **Search/Filter:** Persistent search bar at top with filters for status, doctor, insurance

## Specific Guidelines
- **Phone Layout:** 
  - Each patient in a card with: ID, Name, Status, Last Visit
  - Card tappable to navigate to Patient Profile
  - Swipe actions for quick tasks (e.g., check-in, view details)
- **Tablet Layout:**
  - Table with columns: ID, Name, Status, Doctor, Insurance, Last Visit, Actions
  - Sortable columns
  - Row selection for batch actions
- **Search:** 
  - Debounced search on input change
  - Filter chips for quick filtering
- **Empty State:** Show message and icon when no patients match
- **Loading State:** Show skeleton loader for list/table
- **Error State:** Show error message and retry button

## Components Used
- SearchBar (with debounce)
- FilterChip
- ListView (phone) / DataTable (tablet) or PaginatedDataTable
- Card (phone)
- Table, DataRow, DataCell (tablet)
- IconButton (for actions)
- CircularProgressIndicator (loading)
- EmptyStateWidget (custom)

## Notes
- This screen overrides the layout to be adaptive between phone and tablet.
- All other rules from MASTER.md apply.
