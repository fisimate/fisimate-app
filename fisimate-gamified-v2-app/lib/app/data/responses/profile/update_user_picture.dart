class UpdateUserPictureResponse {
  bool success;
  String message;
  UserData data;

  UpdateUserPictureResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UpdateUserPictureResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserPictureResponse(
      success: json['success'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  String id;
  String fullname;
  String email;
  String nis;
  String profilePicture;
  String roleId;
  DateTime createdAt;
  DateTime updatedAt;

  UserData({
    required this.id,
    required this.fullname,
    required this.email,
    required this.nis,
    required this.profilePicture,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      nis: json['nis'],
      profilePicture: json['profilePicture'],
      roleId: json['roleId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
