import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LoginService {
  Future<User?> login(String email, String password) async {
    var authInstance = FirebaseAuth.instance;
    try {
      final credentials = await authInstance.signInWithEmailAndPassword(
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

  void logout(User currentUser) async {
    if(currentUser.emailVerified && currentUser.metadata.creationTime != null){
      var authService = FirebaseAuth.instance;
      try {
        await authService.signOut();
      } on FirebaseAuthException catch (exception) {
        if (kDebugMode) {
          print(exception.message);
        }
      } finally {
        authService.authStateChanges();
      }
    }
  }

  bool resetPassword(String newPassword){
    if(newPassword.isNotEmpty){
      return true;
    }

    return false;
  }
}