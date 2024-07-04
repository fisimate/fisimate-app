// To parse this JSON data, do
//
//     final simulation = simulationFromJson(jsonString);

import 'dart:convert';

List<Simulation> simulationFromJson(String str) => List<Simulation>.from(json.decode(str).map((x) => Simulation.fromJson(x)));

String simulationToJson(List<Simulation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Simulation {
    String? id;
    String? title;
    String? icon;
    String? chapterId;
    DateTime? createdAt;
    DateTime? updatedAt;
    Chapter? chapter;

    Simulation({
        this.id,
        this.title,
        this.icon,
        this.chapterId,
        this.createdAt,
        this.updatedAt,
        this.chapter,
    });

    factory Simulation.fromJson(Map<String, dynamic> json) => Simulation(
        id: json["id"],
        title: json["title"],
        icon: json["icon"],
        chapterId: json["chapterId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        chapter: Chapter.fromJson(json["chapter"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "icon": icon,
        "chapterId": chapterId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "chapter": chapter?.toJson(),
    };
}

class Chapter {
    String? id;
    String? name;
    String? slug;
    DateTime? createdAt;
    DateTime? updatedAt;

    Chapter({
        this.id,
        this.name,
        this.slug,
        this.createdAt,
        this.updatedAt,
    });

    factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
