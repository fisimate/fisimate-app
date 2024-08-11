class PostAnswerResponse {
  bool success;
  String message;
  List<SavedResponse> savedResponses;
  int score;
  int notAnswered;
  int answered;

  PostAnswerResponse({
    required this.success,
    required this.message,
    required this.savedResponses,
    required this.score,
    required this.notAnswered,
    required this.answered,
  });

  factory PostAnswerResponse.fromJson(Map<String, dynamic> json) {
    return PostAnswerResponse(
      success: json['success'],
      message: json['message'],
      savedResponses: List<SavedResponse>.from(
        json['data']['savedResponses'].map(
          (response) => SavedResponse.fromJson(response),
        ),
      ),
      score: json['data']['score'],
      notAnswered: json['data']['notAnswered'],
      answered: json['data']['answered'],
    );
  }
}

class SavedResponse {
  String id;
  String quizAttemptId;
  String questionId;
  String selectedOptionId;

  SavedResponse({
    required this.id,
    required this.quizAttemptId,
    required this.questionId,
    required this.selectedOptionId,
  });

  factory SavedResponse.fromJson(Map<String, dynamic> json) {
    return SavedResponse(
      id: json['id'],
      quizAttemptId: json['quizAttemptId'],
      questionId: json['questionId'],
      selectedOptionId: json['selectedOptionId'],
    );
  }
}
