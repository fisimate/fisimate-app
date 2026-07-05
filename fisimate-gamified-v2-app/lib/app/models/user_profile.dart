// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  String? id;
  String? fullname;
  String? email;
  String? nis;
  String? profilePicture;
  String? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Role? role;

  UserProfile({
    this.id,
    this.fullname,
    this.email,
    this.nis,
    this.profilePicture,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"],
    fullname: json["fullname"],
    email: json["email"],
    nis: json["nis"],
    profilePicture: json["profilePicture"],
    roleId: json["roleId"],
    createdAt: json["createdAt"] == null
        ? DateTime.parse(json["createdAt"] ?? DateTime.now().toIso8601String())
        : DateTime.now(),
    updatedAt: json["updateAt"] == null
        ? DateTime.parse(json["updatedAt"] ?? DateTime.now().toIso8601String())
        : DateTime.now(),
    role: Role.fromJson(json["role"] ?? {'id': '1', 'name': 'Student'}),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "email": email,
    "nis": nis,
    "profilePicture": profilePicture,
    "roleId": roleId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "role": role?.toJson(),
  };
}

class Role {
  String? id;
  String? name;

  Role({
    this.id,
    this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
