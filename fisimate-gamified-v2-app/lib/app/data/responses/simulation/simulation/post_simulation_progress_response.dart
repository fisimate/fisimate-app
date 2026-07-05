class PostSimulationProgressResponse {
  final bool success;
  final String message;
  final SimulationProgressData data;

  PostSimulationProgressResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PostSimulationProgressResponse.fromJson(Map<String, dynamic> json) {
    return PostSimulationProgressResponse(
      success: json['success'],
      message: json['message'],
      data: SimulationProgressData.fromJson(json['data']),
    );
  }
}

class SimulationProgressData {
  final String id;
  final String userId;
  final String simulationId;
  final int currentStep;
  final int totalSteps;
  final DateTime createdAt;
  final DateTime updatedAt;

  SimulationProgressData({
    required this.id,
    required this.userId,
    required this.simulationId,
    required this.currentStep,
    required this.totalSteps,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SimulationProgressData.fromJson(Map<String, dynamic> json) {
    return SimulationProgressData(
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
