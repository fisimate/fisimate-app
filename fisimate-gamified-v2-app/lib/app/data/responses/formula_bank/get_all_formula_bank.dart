class GetAllFormulaBankResponse {
  GetAllFormulaBankResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final Data data;

  factory GetAllFormulaBankResponse.fromJson(Map<String, dynamic> json) => GetAllFormulaBankResponse(
    success: json['success'],
    message: json['message'],
    data: Data.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.toJson(),
  };
}

class Data {
  Data({
    required this.count,
    required this.formulaBankChapters,
  });

  final Count count;
  final List<FormulaBankChapter> formulaBankChapters;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    count: Count.fromJson(json['count']),
    formulaBankChapters: List<FormulaBankChapter>.from(json['result'].map((x) => FormulaBankChapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'count': count.toJson(),
    'result': List<dynamic>.from(formulaBankChapters.map((x) => x.toJson())),
  };
}

class Count {
  Count({
    required this.chapters,
    required this.subChapters,
  });

  final int chapters;
  final int subChapters;

  factory Count.fromJson(Map<String, dynamic> json) => Count(
    chapters: json['chapters'],
    subChapters: json['sub_chapters'],
  );

  Map<String, dynamic> toJson() => {
    'chapters': chapters,
    'sub_chapters': subChapters,
  };
}

class FormulaBankChapter {
  FormulaBankChapter({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.shortDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.formulaBankSubChapters,
  });

  final String id;
  final String name;
  final String slug;
  final String icon;
  final String shortDescription;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FormulaBankSubChapter> formulaBankSubChapters;

  factory FormulaBankChapter.fromJson(Map<String, dynamic> json) => FormulaBankChapter(
    id: json['id'],
    name: json['name'],
    slug: json['slug'],
    icon: json['icon'],
    shortDescription: json['shortDescription'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    formulaBankSubChapters: List<FormulaBankSubChapter>.from(json['formulaBanks'].map((x) => FormulaBankSubChapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'icon': icon,
    'shortDescription': shortDescription,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'formulaBanks': List<dynamic>.from(formulaBankSubChapters.map((x) => x.toJson())),
  };
}

class FormulaBankSubChapter {
  FormulaBankSubChapter({
    required this.id,
    required this.title,
    this.icon,
    this.filePath,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String? icon;
  final String? filePath;
  final String chapterId;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory FormulaBankSubChapter.fromJson(Map<String, dynamic> json) => FormulaBankSubChapter(
    id: json['id'],
    title: json['title'],
    icon: json['icon'],
    filePath: json['filePath'],
    chapterId: json['chapterId'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'icon': icon,
    'filePath': filePath,
    'chapterId': chapterId,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}