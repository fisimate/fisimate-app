// To parse this JSON data, do
//
//     final examBankModel = examBankModelFromJson(jsonString);

import 'dart:convert';

ExamBankModel examBankModelFromJson(String str) => ExamBankModel.fromJson(json.decode(str));

String examBankModelToJson(ExamBankModel data) => json.encode(data.toJson());

class ExamBankModel {
    bool success;
    String message;
    List<Datum> data;

    ExamBankModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ExamBankModel.fromJson(Map<String, dynamic> json) => ExamBankModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String name;
    String slug;
    DateTime createdAt;
    DateTime updatedAt;
    List<ExamBank> examBanks;

    Datum({
        required this.id,
        required this.name,
        required this.slug,
        required this.createdAt,
        required this.updatedAt,
        required this.examBanks,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        examBanks: List<ExamBank>.from(json["examBanks"].map((x) => ExamBank.fromJson(x))),
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

class ExamBank {
    String id;
    String title;
    String icon;
    String filePath;
    String chapterId;
    DateTime createdAt;
    DateTime updatedAt;

    ExamBank({
        required this.id,
        required this.title,
        required this.icon,
        required this.filePath,
        required this.chapterId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ExamBank.fromJson(Map<String, dynamic> json) => ExamBank(
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
