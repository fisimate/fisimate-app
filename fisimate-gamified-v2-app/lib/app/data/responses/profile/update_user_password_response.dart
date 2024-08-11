class UpdateUserPasswordResponse {
  final bool success;
  final String message;
  final UserData data;

  UpdateUserPasswordResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UpdateUserPasswordResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserPasswordResponse(
      success: json['success'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final String id;
  final String fullname;
  final String email;
  final String nis;
  final String roleId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Role role;

  UserData({
    required this.id,
    required this.fullname,
    required this.email,
    required this.nis,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
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
