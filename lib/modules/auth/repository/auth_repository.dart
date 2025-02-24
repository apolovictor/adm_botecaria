import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/auth_service.dart';

class AuthRepository {
  final AuthService _authProvider;

  AuthRepository(this._authProvider);

  Future<bool> login(String email, String password) async {
    try {
      return await _authProvider.login(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forgotPassword(String email) {
    try {
      return _authProvider.forgotPassword(email);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _authProvider.logout();
    } catch (e) {
      rethrow;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(authServiceProvider));
});
