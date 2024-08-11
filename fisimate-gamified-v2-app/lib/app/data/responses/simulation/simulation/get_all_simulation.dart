class SimulationDTO {
  final String id;
  final String title;
  final String? icon;
  final String chapterId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Chapter chapter;
  final List<SimulationProgress>? simulationProgress;

  SimulationDTO({
    required this.id,
    required this.title,
    required this.icon,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
    required this.chapter,
    required this.simulationProgress,
  });

  factory SimulationDTO.fromJson(Map<String, dynamic> json) {
    return SimulationDTO(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      chapterId: json['chapterId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      chapter: Chapter.fromJson(json['chapter']),
      simulationProgress: List<SimulationProgress>.from(
        json['simulationProgress'].map(
          (x) => SimulationProgress.fromJson(x),
        ),
      ),
    );
  }
}

class Chapter {
  final String id;
  final String name;
  final String slug;
  final String? icon;
  final String shortDescription;
  final DateTime createdAt;
  final DateTime updatedAt;

  Chapter({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.shortDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      icon: json['icon'],
      shortDescription: json['shortDescription'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class SimulationProgress {
  final String id;
  final String userId;
  final String simulationId;
  final int currentStep;
  final int totalSteps;
  final DateTime createdAt;
  final DateTime updatedAt;

  SimulationProgress({
    required this.id,
    required this.userId,
    required this.simulationId,
    required this.currentStep,
    required this.totalSteps,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SimulationProgress.fromJson(Map<String, dynamic> json) {
    return SimulationProgress(
      id: json['id'],
      userId: json['userId'],
      simulationId: json['simulationId'],
      currentStep: json['currentStep'],
      totalSteps: json['totalSteps'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
