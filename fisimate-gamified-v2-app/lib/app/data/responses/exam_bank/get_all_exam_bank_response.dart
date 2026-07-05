class GetAllExamBankResponse {
  GetAllExamBankResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final Data data;

  factory GetAllExamBankResponse.fromJson(Map<String, dynamic> json) => GetAllExamBankResponse(
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
    required this.examBankChapters,
  });

  final Count count;
  final List<ExamBankChapter> examBankChapters;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    count: Count.fromJson(json['count']),
    examBankChapters: List<ExamBankChapter>.from(json['result'].map((x) => ExamBankChapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'count': count.toJson(),
    'result': List<dynamic>.from(examBankChapters.map((x) => x.toJson())),
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

class ExamBankChapter {
  ExamBankChapter({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.shortDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.examBankSubChapters,
  });

  final String id;
  final String name;
  final String slug;
  final String icon;
  final String shortDescription;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ExamBankSubChapter> examBankSubChapters;

  factory ExamBankChapter.fromJson(Map<String, dynamic> json) => ExamBankChapter(
    id: json['id'],
    name: json['name'],
    slug: json['slug'],
    icon: json['icon'],
    shortDescription: json['shortDescription'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    examBankSubChapters: List<ExamBankSubChapter>.from(json['examBanks'].map((x) => ExamBankSubChapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'icon': icon,
    'shortDescription': shortDescription,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'formulaBanks': List<dynamic>.from(examBankSubChapters.map((x) => x.toJson())),
  };
}

class ExamBankSubChapter {
  ExamBankSubChapter({
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

  factory ExamBankSubChapter.fromJson(Map<String, dynamic> json) => ExamBankSubChapter(
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
