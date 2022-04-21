class UserProfileModel {
  late String name, userId, imageUrl;
  late DateTime joinedOn;

  UserProfileModel({
    required this.userId,
    required this.name,
    required this.joinedOn,
    this.imageUrl = "",
  });

  UserProfileModel.fromJson(
    Map<String, dynamic> map,
  ) {
    name = map["name"];
    joinedOn = map["joinedOn"].toDate();
    userId = map["userId"];
    imageUrl = map["imageUrl"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "name": name,
      "joinedOn": joinedOn,
      "imageUrl": imageUrl,
    };
  }
}
