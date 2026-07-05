class UpdateUserProfileResponse {
  final bool success;
  final String message;
  final UserProfile data;

  UpdateUserProfileResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UpdateUserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserProfileResponse(
      success: json['success'],
      message: json['message'],
      data: UserProfile.fromJson(json['data']),
    );
  }
}

class UserProfile {
  final String id;
  final String fullname;
  final String email;
  final String nis;
  final String roleId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Role role;

  UserProfile({
    required this.id,
    required this.fullname,
    required this.email,
    required this.nis,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      nis: json['nis'],
      roleId: json['roleId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      role: Role.fromJson(json['role']),
    );
  }
}

class Role {
  final String id;
  final String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
    );
  }
}
