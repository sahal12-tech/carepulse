/// CarePulse API Client Stub
/// 
/// Note: Backend is provided separately (FastAPI).
/// All network integration will be injected into this stub.
class ApiClient {
  ApiClient._();

  static const String baseUrl = 'http://localhost:8000/api/v1';

  // TODO: Add http/dio client implementation when connecting to FastAPI backend
  // TODO: Add request interceptors for Auth tokens
  // TODO: Add error handling and response parsing wrappers
}
