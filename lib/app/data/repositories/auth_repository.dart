import '../../core/constants/app_constants.dart';

abstract class AuthRepository {
  Future<bool> login({
    required String username,
    required String password,
    required UserRole role,
  });

  Future<void> logout();

  UserRole? getCurrentRole();
  String? getCurrentUsername();
  bool get isAuthenticated;
}

class MockAuthRepository implements AuthRepository {
  UserRole? _currentRole;
  String? _username;
  bool _authenticated = false;

  @override
  Future<bool> login({
    required String username,
    required String password,
    required UserRole role,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    if (username.trim().isNotEmpty && password.trim().isNotEmpty) {
      _currentRole = role;
      _username = username.trim();
      _authenticated = true;
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentRole = null;
    _username = null;
    _authenticated = false;
  }

  @override
  UserRole? getCurrentRole() => _currentRole ?? UserRole.receptionist;

  @override
  String? getCurrentUsername() => _username ?? 'Dr. Sarah Jenkins';

  @override
  bool get isAuthenticated => _authenticated;
}
