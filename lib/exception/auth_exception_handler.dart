import 'package:firebase_auth/firebase_auth.dart';

import 'auth_result_status.dart';

class AuthExceptionHandler {
  static handleException(e){
    AuthResultStatus status;
    switch(e.code){
      case "INVALID_EMAIL":
        status = AuthResultStatus.invalidEmail;
        break;
      case "WRONG_PASSWORD":
        status = AuthResultStatus.wrongPassword;
        break;
      case "USER_NOT_FOUND":
        status = AuthResultStatus.userNotFound;
        break;
      case "USER_DISABLED":
        status = AuthResultStatus.userDisabled;
        break;
      case "TOO_MANY_REQUESTS":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "OPERATION_NOT_ALLOWED":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "EMAIL_ALREADY_IN_USE":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case "INVALID_LOGIN_CREDENTIALS":
        status = AuthResultStatus.invalidLoginCredentials;
        break;
      default:
        status = AuthResultStatus.undefined;
        break;
    }
    return status;
  }

  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Your email address is either invalid or does not have "
            "the right format.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Wrong Password.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled. Please contact "
            "the support for more information";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
        "The email has already been registered. Please login or reset your password.";
        break;
      case AuthResultStatus.invalidLoginCredentials:
        errorMessage =
            "Wrong email or password. Please check your credentials and try again.";
        break;
      default:
        errorMessage = "An undefined Error happened. We are trying to resolve it. "
            "Please stand by...";
        break;
    }
    return errorMessage;
  }
}