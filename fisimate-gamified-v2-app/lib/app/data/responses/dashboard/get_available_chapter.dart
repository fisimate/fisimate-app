class AvailableChapter {
  bool success;
  String message;
  List<ChapterData> data;

  AvailableChapter({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AvailableChapter.fromJson(Map<String, dynamic> json) {
    return AvailableChapter(
      success: json['success'],
      message: json['message'],
      data: List<ChapterData>.from(
        json['data'].map(
          (x) => ChapterData.fromJson(x),
        ),
      ),
    );
  }
}

class ChapterData {
  String id;
  String name;
  String slug;
  String icon;
  String shortDescription;
  DateTime createdAt;
  DateTime updatedAt;
  List<MaterialBankData> materialBanks;
  List<FormulaBankData> formulaBanks;
  List<ExamBankData> examBanks;
  List<SimulationData> simulations;

  ChapterData({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.shortDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.materialBanks,
    required this.formulaBanks,
    required this.examBanks,
    required this.simulations,
  });

  factory ChapterData.fromJson(Map<String, dynamic> json) {
    return ChapterData(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      icon: json['icon'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      materialBanks: List<MaterialBankData>.from(
        (json['materialBanks'] as List? ?? []).map(
          (x) => MaterialBankData.fromJson(x),
        ),
      ),
      formulaBanks: List<FormulaBankData>.from(
        (json['formulaBanks'] as List? ?? []).map(
          (x) => FormulaBankData.fromJson(x),
        ),
      ),
      examBanks: List<ExamBankData>.from(
        (json['examBanks'] as List? ?? []).map(
          (x) => ExamBankData.fromJson(x),
        ),
      ),
      simulations: List<SimulationData>.from(
        (json['simulations'] as List? ?? []).map(
          (x) => SimulationData.fromJson(x),
        ),
      ),
    );
  }
}

class MaterialBankData {
  String id;
  String title;
  String icon;
  String filePath;
  String chapterId;
  DateTime createdAt;
  DateTime updatedAt;

  MaterialBankData({
    required this.id,
    required this.title,
    required this.icon,
    required this.filePath,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MaterialBankData.fromJson(Map<String, dynamic> json) {
    return MaterialBankData(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      filePath: json['filePath'],
      chapterId: json['chapterId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class FormulaBankData {
  String id;
  String title;
  String icon;
  String filePath;
  String chapterId;
  DateTime createdAt;
  DateTime updatedAt;

  FormulaBankData({
    required this.id,
    required this.title,
    required this.icon,
    required this.filePath,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FormulaBankData.fromJson(Map<String, dynamic> json) {
    return FormulaBankData(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      filePath: json['filePath'],
      chapterId: json['chapterId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class ExamBankData {
  String id;
  String title;
  String icon;
  String filePath;
  String chapterId;
  DateTime createdAt;
  DateTime updatedAt;

  ExamBankData({
    required this.id,
    required this.title,
    required this.icon,
    required this.filePath,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExamBankData.fromJson(Map<String, dynamic> json) {
    return ExamBankData(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      filePath: json['filePath'],
      chapterId: json['chapterId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class SimulationData {
  String id;
  String title;
  String icon;
  String chapterId;
  DateTime createdAt;
  DateTime updatedAt;

  SimulationData({
    required this.id,
    required this.title,
    required this.icon,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SimulationData.fromJson(Map<String, dynamic> json) {
    return SimulationData(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      chapterId: json['chapterId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
