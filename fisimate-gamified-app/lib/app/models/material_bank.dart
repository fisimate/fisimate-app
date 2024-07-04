// To parse this JSON data, do
//
//     final materialBank = materialBankFromJson(jsonString);

import 'dart:convert';

MaterialBank materialBankFromJson(String str) =>
    MaterialBank.fromJson(json.decode(str));

String materialBankToJson(MaterialBank data) => json.encode(data.toJson());

class MaterialBank {
  Count? count;
  List<Result>? result;

  MaterialBank({
    this.count,
    this.result,
  });

  factory MaterialBank.fromJson(Map<String, dynamic> json) => MaterialBank(
        count: Count.fromJson(json["count"]),
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count!.toJson(),
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Count {
  int? chapters;
  int? subChapters;

  Count({
    this.chapters,
    this.subChapters,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        chapters: json["chapters"],
        subChapters: json["sub_chapters"],
      );

  Map<String, dynamic> toJson() => {
        "chapters": chapters,
        "sub_chapters": subChapters,
      };
}

class Result {
  String? id;
  String? name;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<MaterialBankElement>? materialBanks;

  Result({
    this.id,
    this.name,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.materialBanks,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        materialBanks: List<MaterialBankElement>.from(
            json["materialBanks"].map((x) => MaterialBankElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "materialBanks":
            List<dynamic>.from(materialBanks!.map((x) => x.toJson())),
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
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "icon": icon,
        "filePath": filePath,
        "chapterId": chapterId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
