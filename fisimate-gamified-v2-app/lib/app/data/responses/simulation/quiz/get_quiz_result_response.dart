class QuizResultResponse {
  final bool success;
  final String message;
  final QuizResultData data;

  QuizResultResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory QuizResultResponse.fromJson(Map<String, dynamic> json) {
    return QuizResultResponse(
      success: json['success'],
      message: json['message'],
      data: QuizResultData.fromJson(json['data']),
    );
  }
}

class QuizResultData {
  final int score;
  final int correctResponses;
  final int incorrectResponses;

  QuizResultData({
    required this.score,
    required this.correctResponses,
    required this.incorrectResponses,
  });

  factory QuizResultData.fromJson(Map<String, dynamic> json) {
    return QuizResultData(
      score: json['score'],
      correctResponses: json['correctResponses'],
      incorrectResponses: json['incorrectResponses'],
    );
  }
}
