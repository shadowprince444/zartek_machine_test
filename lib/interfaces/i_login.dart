import 'package:firebase_auth/firebase_auth.dart';

abstract class ILogInRepo {
  Future signUp(
    String mob,
    Function(User) onUserVerified,
    Function(String, int?) onCodeSent,
    Function(String) onAutoCodeRetrievalTimeout,
  ) async {}
  Future googleSignIn() async {}

  Future otpChecker(String otp, String verificationId) async {}
}
