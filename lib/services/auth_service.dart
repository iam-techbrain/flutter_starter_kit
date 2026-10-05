import 'package:flutter/foundation.dart';
import '../models/auth_user.dart';

/// Simple, robust auth state manager using Flutter's built-in ChangeNotifier/ValueNotifier.
/// Allows any page or component to listen to login/logout states cleanly.
class AuthService {
  // Singleton pattern for centralized access across screens
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final ValueNotifier<AuthUser?> currentUserNotifier = ValueNotifier<AuthUser?>(null);

  AuthUser? get currentUser => currentUserNotifier.value;
  bool get isAuthenticated => currentUserNotifier.value != null;
  String? get token => currentUserNotifier.value?.token;

  void setAuthenticatedUser(AuthUser user) {
    currentUserNotifier.value = user;
  }

  void logout() {
    currentUserNotifier.value = null;
  }
}
