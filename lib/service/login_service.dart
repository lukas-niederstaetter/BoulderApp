import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LoginService {
  final _authInstance = FirebaseAuth.instance;

  Future<User?> login(String email, String password) async {
    try {
      final credentials = await _authInstance.signInWithEmailAndPassword(
        email: email,
        password: password);
      return credentials.user;
    } on FirebaseAuthException catch (exception) {
      if (kDebugMode) {
        print(exception.message);
      }
    }
    return null;
  }
}