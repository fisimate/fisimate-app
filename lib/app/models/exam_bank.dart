// To parse this JSON data, do
//
//     final examBank = examBankFromJson(jsonString);

import 'dart:convert';

List<ExamBank> examBankFromJson(String str) => List<ExamBank>.from(json.decode(str).map((x) => ExamBank.fromJson(x)));

String examBankToJson(List<ExamBank> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExamBank {
    String id;
    String name;
    String slug;
    DateTime createdAt;
    DateTime updatedAt;
    List<ExamBankElement> examBanks;

    ExamBank({
        required this.id,
        required this.name,
        required this.slug,
        required this.createdAt,
        required this.updatedAt,
        required this.examBanks,
    });

    factory ExamBank.fromJson(Map<String, dynamic> json) => ExamBank(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        examBanks: List<ExamBankElement>.from(json["examBanks"].map((x) => ExamBankElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "examBanks": List<dynamic>.from(examBanks.map((x) => x.toJson())),
    };
}

class ExamBankElement {
    String id;
    String title;
    String icon;
    String filePath;
    String chapterId;
    DateTime createdAt;
    DateTime updatedAt;

    ExamBankElement({
        required this.id,
        required this.title,
        required this.icon,
        required this.filePath,
        required this.chapterId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ExamBankElement.fromJson(Map<String, dynamic> json) => ExamBankElement(
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
