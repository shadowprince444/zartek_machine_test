import 'package:zartek_machine_test/models/user_profile_model.dart';

abstract class IProfileRepo {
  Future addUserProfile(UserProfileModel userProfileModel) async {}
  Future getUserProfile(String userId) async {}
}
