// To parse this JSON data, do
//
//     final materialBank = materialBankFromJson(jsonString);

import 'dart:convert';

List<MaterialBank> materialBankFromJson(String str) => List<MaterialBank>.from(
    json.decode(str).map((x) => MaterialBank.fromJson(x)));

String materialBankToJson(List<MaterialBank> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialBank {
  String? id;
  String? name;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<MaterialBankElement>? materialBanks;

  MaterialBank({
    this.id,
    this.name,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.materialBanks,
  });

  factory MaterialBank.fromJson(Map<String, dynamic> json) => MaterialBank(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],

        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        materialBanks: json["materialBanks"] == null
            ? []
            : List<MaterialBankElement>.from(json["materialBanks"]!
                .map((x) => MaterialBankElement.fromJson(x))),

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,

        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "materialBanks": materialBanks == null
            ? []
            : List<dynamic>.from(materialBanks!.map((x) => x.toJson())),

      };
}

class MaterialBankElement {
  String? id;
  String? title;
  String? icon;
  String? filePath;
  String? chapterId;
  DateTime? createdAt;
  DateTime? updatedAt;

  MaterialBankElement({
    this.id,
    this.title,
    this.icon,
    this.filePath,
    this.chapterId,
    this.createdAt,
    this.updatedAt,
  });

  factory MaterialBankElement.fromJson(Map<String, dynamic> json) =>
      MaterialBankElement(
        id: json["id"],
        title: json["title"],
        icon: json["icon"],
        filePath: json["filePath"],
        chapterId: json["chapterId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "icon": icon,
        "filePath": filePath,
        "chapterId": chapterId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
