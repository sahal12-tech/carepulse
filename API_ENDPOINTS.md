# CarePulse API Endpoints

## Auth Router
| Method | Path | Description | Roles |
|--------|------|-------------|-------|
| POST | /auth/login | User login | A, D, R |
| GET | /auth/me | Get current user info | A, D, R |
| POST | /auth/logout | User logout | A, D, R |

## Patients Router
| Method | Path | Description | Roles |
|--------|------|-------------|-------|
| GET | /patients?search&status&sort_by&order&page&limit | List patients with filtering, sorting, pagination | A, D, R |
| POST | /patients | Create new patient | A, R |
| GET | /patients/{patient_id} | Get patient by ID | A, D, R |
| PUT | /patients/{patient_id} | Update patient | A, R |
| PATCH | /patients/{patient_id}/status | Update patient status | A, D |
| DELETE | /patients/{patient_id} | Soft delete patient | A |
| GET | /patients/{patient_id}/visits | Get patient visits | A, D |
| POST | /patients/{patient_id}/visits | Add visit for patient | D |
| GET | /patients/{patient_id}/allergies | Get patient allergies | A, D, R |
| POST | /patients/{patient_id}/allergies | Add allergy for patient | D |
| DELETE | /patients/{patient_id}/allergies/{allergy_id} | Delete allergy | D |

## Appointments Router
| Method | Path | Description | Roles |
|--------|------|-------------|-------|
| GET | /appointments?date&status&doctor_id&patient_id | List appointments with filtering | A, D, R |
| POST | /appointments | Create new appointment | A, R |
| GET | /appointments/{appointment_id} | Get appointment by ID | A, D, R |
| PUT | /appointments/{appointment_id} | Update appointment | A, R |
| PATCH | /appointments/{appointment_id}/status | Update appointment status | A, D, R |

## Doctors/Users Router
| Method | Path | Description | Roles |
|--------|------|-------------|-------|
| GET | /doctors | List doctors | A, R |
| GET | /doctors/{doctor_id} | Get doctor by ID | A, D, R |
| GET | /users | List users | A |
| POST | /users | Create new user | A |
| PATCH | /users/{user_id} | Update user | A |

## Dashboard Router
| Method | Path | Description | Roles |
|--------|------|-------------|-------|
| GET | /dashboard/summary | Get dashboard summary | A, D, R |
| GET | /dashboard/today | Get today's dashboard data | A, D, R |

## Emergency Router
| Method | Path | Description | Roles |
|--------|------|-------------|-------|
| POST | /emergency | Create emergency case | A, D, R |
| GET | /emergency | List emergency cases | A, D, R |
| PATCH | /emergency/{case_id}/link-patient | Link patient to emergency case | A, R |
