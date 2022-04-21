import 'package:country_code_picker/country_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zartek_machine_test/repository/log_in_repo.dart';
import 'package:zartek_machine_test/repository/profile_repo.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/enums.dart';

class SignInController with ChangeNotifier {
  SignInStatus signInStatus = SignInStatus.none;

  final _logInRepo = LogInRepo();
  String userIdForLogIn = "", token = "";
  resetState() {
    signInStatus = SignInStatus.none;
    userIdForLogIn = "";
    token = "";
    countryCode = "+91";
    phoneNumber = "";
    // countryCodeList = ["+91", "+92", "+234"];

    _isAuthenticated = null;
    _phoneAuthState = PhoneAuthState.started;
    _verificationId = "0";
    errorMessage = '';
    notifyListeners();
  }

  changeLogInMethod(SignInStatus method) {
    signInStatus = method;
    notifyListeners();
  }

//region $PhoneNumberAuthentication
  String countryCode = "+91", phoneNumber = "";
  List<String> countryCodeList = ["+91", "+92", "+234"];

  UserCredential? _isAuthenticated;
  PhoneAuthState _phoneAuthState = PhoneAuthState.started;
  static String _verificationId = "0";
  String errorMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  PhoneAuthState get phoneAuthState => _phoneAuthState;

  String get verificationId => _verificationId;

  UserCredential? get isAuthenticated => _isAuthenticated;

  onChangeCountryCode(CountryCode code) {
    countryCode = code.dialCode ?? "";
  }

  onTapResend() {}

  onPhoneNumberChanged(String number) {
    phoneNumber = number;
  }

  clearPhoneAuthState() {
    _phoneAuthState = PhoneAuthState.started;
  }

  Future onSendOtpTapped() async {
    await _logInRepo.signUp(
      countryCode + phoneNumber,
      (p1) => onUserVerified(p1),
      (p1, p2) => onCodeSent(p1, p2),
      (p1) => onAutoCodeRetrievalTimeout(p1),
    );
  }

  void onAutoCodeRetrievalTimeout(
    verificationId,
  ) async {
    _phoneAuthState = PhoneAuthState.autoRetrievalTimeOut;
    notifyListeners();
  }

  void onCodeSent(String verId, [int? forceCodeResend]) async {
    if (verId != _verificationId) {
      _verificationId = verId;
      _phoneAuthState = PhoneAuthState.codeSent;
      notifyListeners();
    }
  }

  Future<User> onUserVerified(User user) async {
    userIdForLogIn = user.uid;
    token = await user.getIdToken();

    _phoneAuthState = PhoneAuthState.verified;
    print("------------------------------------User Verified------------------------------------------------");
    signInStatus = SignInStatus.signedIn;
    notifyListeners();
    return user;
  }

  Future<UserCredential?> otpChecker(String? otp) async {
    if (otp != null) {
      if (otp.length == 6) {
        PhoneAuthCredential authCredential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: otp);
        try {
          final user = await _auth.signInWithCredential(authCredential);
          _phoneAuthState = PhoneAuthState.verified;
          print("------------------------------------User Verified------------------------------------------------");
          signInStatus = SignInStatus.signedIn;
          notifyListeners();
          return user;
        } on FirebaseAuthException catch (e) {
          print(e.message);
          return null;
        }
      }
    }
  }

//endregion

  Future<User?> googleSignIn() async {
    final response = await _logInRepo.googleSignIn();
    if (response.status == ApiResponseStatus.completed) {
      return await onUserVerified(response.data!);
    } else {
      return null;
    }
  }
}
