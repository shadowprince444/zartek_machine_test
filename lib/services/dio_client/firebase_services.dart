import 'package:firebase_auth/firebase_auth.dart';
import 'package:zartek_machine_test/models/api_response_model.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUp(
    String mob,
    Function(PhoneAuthCredential) onUserVerified,
    Function(String, int?) onCodeSent,
    Function(String) onAutoCodeRetrievalTimeout,
  ) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91" + mob,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          final user = await _auth.signInWithCredential(phoneAuthCredential);
          _auth.authStateChanges().listen((firebaseUser) {
            Future.delayed(const Duration(milliseconds: 200), () async {
              if (_auth.currentUser != null) {
                onUserVerified(phoneAuthCredential);
              }
            });
          });
        },
        verificationFailed: (FirebaseAuthException error) {
          print("-----------------------------------Verification Failed------------------------------------------------");
        },
        codeSent: onCodeSent,
        timeout: const Duration(seconds: 10),
        codeAutoRetrievalTimeout: onAutoCodeRetrievalTimeout,
      );
    } catch (e) {}
  }

  Future<ApiResponse<UserCredential>> otpchecker(String otp, String verificationId) async {
    PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    try {
      final user = await _auth.signInWithCredential(authCredential);
      return ApiResponse<UserCredential>.completed(user);
    } on FirebaseAuthException catch (e) {
      return ApiResponse<UserCredential>.error(e.message);
      // return null;
    } catch (e) {
      return ApiResponse<UserCredential>.error(e.toString());
    }
  }
}
