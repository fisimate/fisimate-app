class UserProfileDTO {
  final String id;
  final String fullname;
  final String email;
  final String nis;
  final String? profilePicture;
  final String roleId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final RoleDTO role;

  UserProfileDTO({
    required this.id,
    required this.fullname,
    required this.email,
    required this.nis,
    required this.profilePicture,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
  });

  factory UserProfileDTO.fromJson(Map<String, dynamic> json) {
    return UserProfileDTO(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      nis: json['nis'],
      profilePicture: json['profilePicture'],
      roleId: json['roleId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      role: RoleDTO.fromJson(json['role']),
    );
  }
}

class RoleDTO {
  final String id;
  final String name;

  RoleDTO({
    required this.id,
    required this.name,
  });

  factory RoleDTO.fromJson(Map<String, dynamic> json) {
    return RoleDTO(
      id: json['id'],
      name: json['name'],
    );
  }
}
