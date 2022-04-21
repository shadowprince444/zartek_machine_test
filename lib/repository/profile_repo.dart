import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zartek_machine_test/interfaces/i_profile.dart';
import 'package:zartek_machine_test/models/api_response_model.dart';
import 'package:zartek_machine_test/models/user_profile_model.dart';

class ProfileRepo implements IProfileRepo {
  final _firebaseAuth = FirebaseAuth.instance;
  final _userCollection = FirebaseFirestore.instance.collection("users");

  @override
  Future<ApiResponse<String>> addUserProfile(UserProfileModel userProfileModel) async {
    try {
      await _userCollection.doc(userProfileModel.userId).set(userProfileModel.toJson());
      return ApiResponse<String>.completed("Success");
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse<String>.error("Failed to add user data");
    }
  }

  @override
  Future<ApiResponse<UserProfileModel>> getUserProfile(String userId) async {
    try {
      final response = await _userCollection.doc(userId).get();
      if (response.exists) {
        if (response.data() != null) {
          return ApiResponse<UserProfileModel>.completed(
            UserProfileModel.fromJson(
              response.data()!,
            ),
          );
        }
      }
      return ApiResponse<UserProfileModel>.notFound();
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse<UserProfileModel>.error(
        e.toString(),
      );
    }
  }

  Future logOut() async {
    try {
      await _firebaseAuth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      print(e);
    }
  }
}
