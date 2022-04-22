import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:zartek_machine_test/models/user_profile_model.dart';
import 'package:zartek_machine_test/repository/profile_repo.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/enums.dart';

class ProfileController with ChangeNotifier {
  final _profileRepo = ProfileRepo();
  UserProfileModel? userModel;
  String? userId;

//region $AddProfile

  onNameFieldChanged(String? value) => name = value ?? "";
  String name = "";
  String imageUrl = "";

  uploadUserImage(File imageFile) async {
    try {
      imageUrl = await FirebaseStorage.instance.ref().child("Profile Images").putFile(imageFile).then((task) {
        return task.ref.getDownloadURL();
      });
      print(imageUrl);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

//endregion
  updateUserId(String? newUserId) {
    if (userId != newUserId) {
      userId = newUserId;
      notifyListeners();
    }
  }

  Future<InitialScreenStatus> getUserProfile(String newUserId) async {
    print(userId);
    final response = await _profileRepo.getUserProfile(userId ?? newUserId);
    if (response.status == ApiResponseStatus.completed) {
      userModel = response.data;
      return InitialScreenStatus.authenticated;
    } else {
      return InitialScreenStatus.firstLogIn;
    }
  }

  Future<bool> addUserData(
    String userId,
  ) async {
    var userProfileModel = UserProfileModel(
      userId: userId,
      name: name,
      joinedOn: DateTime.now(),
      imageUrl: imageUrl,
    );
    final response = await _profileRepo.addUserProfile(
      userProfileModel,
    );
    if (response.status == ApiResponseStatus.completed) {
      userModel = userProfileModel;
      notifyListeners();
      return true;
    }
    return false;
  }
}
