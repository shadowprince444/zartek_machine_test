import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zartek_machine_test/interfaces/i_login.dart';
import 'package:zartek_machine_test/models/api_response_model.dart';

class LogInRepo implements ILogInRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<ApiResponse<UserCredential>> otpChecker(String otp, String verificationId) async {
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

  @override
  Future signUp(
    String mob,
    Function(User p1) onUserVerified,
    Function(String p1, int? p2) onCodeSent,
    Function(String p1) onAutoCodeRetrievalTimeout,
  ) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: mob,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          final user = await _auth.signInWithCredential(phoneAuthCredential);
          _auth.authStateChanges().listen((firebaseUser) {
            Future.delayed(const Duration(milliseconds: 200), () async {
              if (_auth.currentUser != null) {
                onUserVerified(_auth.currentUser!);
              }
            });
          });
        },
        verificationFailed: (FirebaseAuthException error) {
          print("-----------------------------------Verification Failed------------------------------------------------");
          print(error.message);
        },
        codeSent: onCodeSent,
        timeout: const Duration(seconds: 10),
        codeAutoRetrievalTimeout: onAutoCodeRetrievalTimeout,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<ApiResponse<User>> googleSignIn() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential authResult = await _auth.signInWithCredential(credential);
        User? user = authResult.user;
        if (user != null) {
          return ApiResponse.completed(user);
          // // assert(!_user.isAnonymous);
          // // assert(await _user.getIdToken() != null);
          // user.getIdToken();
          // // assert(user.uid == currentUser.uid);
          // // model.state = ViewState.Idle;
          // print("User Name: ${user.displayName}");
          // print("User Email ${user.email}");
        } else {
          return ApiResponse.error("Unable to authenticate to firebase");
        }
      } else {
        return ApiResponse.error("Unable to authenticate using google");
      }
    } catch (e) {
      return ApiResponse.error("$e");
    }
  }
}
