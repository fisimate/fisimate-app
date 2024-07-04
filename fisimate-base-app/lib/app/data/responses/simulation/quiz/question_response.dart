class QuestionResponse {
  final bool success;
  final String message;
  final QuestionData data;

  QuestionResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuestionResponse(
      success: json['success'],
      message: json['message'],
      data: QuestionData.fromJson(json['data']),
    );
  }
}

class QuestionData {
  final String id;
  final String simulationId;
  final String createdAt;
  final String updatedAt;
  final List<Question> questions;

  QuestionData({
    required this.id,
    required this.simulationId,
    required this.createdAt,
    required this.updatedAt,
    required this.questions,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      id: json['id'],
      simulationId: json['simulationId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      questions: List<Question>.from(
        json['questions'].map(
          (x) => Question.fromJson(x),
        ),
      ),
    );
  }
}

class Question {
  final String id;
  final String text;
  final String quizId;
  final String createdAt;
  final String updatedAt;

  Question({
    required this.id,
    required this.text,
    required this.quizId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      text: json['text'],
      quizId: json['quizId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class QuizOption {
  final String id;
  final String text;
  final bool isCorrect;
  final String questionId;
  final String createdAt;
  final String updatedAt;

  QuizOption({
    required this.id,
    required this.text,
    required this.isCorrect,
    required this.questionId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuizOption.fromJson(Map<String, dynamic> json) {
    return QuizOption(
      id: json['id'],
      text: json['text'],
      isCorrect: json['isCorrect'],
      questionId: json['questionId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
