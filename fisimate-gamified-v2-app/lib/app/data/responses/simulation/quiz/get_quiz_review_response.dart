class GetQuizReviewResponse {
  final bool success;
  final String message;
  final QuizReviewData data;

  GetQuizReviewResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetQuizReviewResponse.fromJson(Map<String, dynamic> json) {
    return GetQuizReviewResponse(
      success: json['success'],
      message: json['message'],
      data: QuizReviewData.fromJson(json['data']),
    );
  }
}

class QuizReviewData {
  final String id;
  final String? filePath;
  final String simulationId;
  final DateTime createdAt;
  final DateTime updatedAt;

  QuizReviewData({
    required this.id,
    this.filePath,
    required this.simulationId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuizReviewData.fromJson(Map<String, dynamic> json) {
    return QuizReviewData(
      id: json['id'],
      filePath: json['filePath'],
      simulationId: json['simulationId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}