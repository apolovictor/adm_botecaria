import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/helpers/firebase_errors.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      return Future.error(getAuthErrorCode(e.code));
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      debugPrint("e ==== $e");
      return Future.error(getAuthErrorCode(e.code));
      // throw AuthException(
      //     e.code, e.message ?? 'Ocorreu um erro. Por favor contate o suporte');
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return Future.error(getAuthErrorCode(e.code));
    }
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
