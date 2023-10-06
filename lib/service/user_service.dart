import 'package:boulder_app/exception/auth_exception_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../exception/auth_result_status.dart';

class UserService {
  final _auth = FirebaseAuth.instance;
  late AuthResultStatus _status;

  Future<AuthResultStatus> createUserAccount({email, password}) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(authResult.user != null){
        _status = AuthResultStatus.successful;
      }
      else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> login({email, password}) async {
    try {
      var authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if(authResult.user != null){
        _status = AuthResultStatus.successful;
      }
      else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  void logoutUser(){
    _auth.signOut();
  }
}