import 'package:flutter/material.dart';
import 'package:zartek_machine_test/repository/profile_repo.dart';

class Auth with ChangeNotifier {
  String? _jwtToken, _userId;

  get jwtToken => _jwtToken;

  get userId => _userId;

  store(String jwt, String userId) {
    if (userId != null) {
      print(jwt + "++++++++" + userId);
      _jwtToken = jwt;
      _userId = userId;
      notifyListeners();
    }
  }

  Future logOut() async {
    await ProfileRepo().logOut();
    _userId = null;
    _jwtToken = null;
    notifyListeners();
  }
}
