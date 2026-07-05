// To parse this JSON data, do
//
//     final formulaBank = formulaBankFromJson(jsonString);

import 'dart:convert';

List<FormulaBank> formulaBankFromJson(String str) =>
    List<FormulaBank>.from(json.decode(str).map((x) => FormulaBank.fromJson(x)));

String formulaBankToJson(List<FormulaBank> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FormulaBank {
  String? id;
  String? name;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<FormulaBankElement>? formulaBanks;

  FormulaBank({
    this.id,
    this.name,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.formulaBanks,
  });

  factory FormulaBank.fromJson(Map<String, dynamic> json) => FormulaBank(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    formulaBanks: json["formulaBanks"] == null
        ? []
        : List<FormulaBankElement>.from(json["formulaBanks"]!.map((x) => FormulaBankElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "formulaBanks": formulaBanks == null ? [] : List<dynamic>.from(formulaBanks!.map((x) => x.toJson())),
  };
}

class FormulaBankElement {
  String? id;
  String? title;
  String? icon;
  String? filePath;
  String? chapterId;
  DateTime? createdAt;
  DateTime? updatedAt;

  FormulaBankElement({
    this.id,
    this.title,
    this.icon,
    this.filePath,
    this.chapterId,
    this.createdAt,
    this.updatedAt,
  });

  factory FormulaBankElement.fromJson(Map<String, dynamic> json) => FormulaBankElement(
    id: json["id"],
    title: json["title"],
    icon: json["icon"],
    filePath: json["filePath"],
    chapterId: json["chapterId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
