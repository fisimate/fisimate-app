class QuestionResponse {
  bool success;
  String message;
  QuestionData data;

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
  String id;
  String title;
  String icon;
  String chapterId;
  String createdAt;
  String updatedAt;
  List<Question> questions;

  QuestionData({
    required this.id,
    required this.title,
    required this.icon,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
    required this.questions,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      chapterId: json['chapterId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      questions: List<Question>.from(
        json['question'].map((question) => Question.fromJson(question)),
      ),
    );
  }
}

class Question {
  String id;
  String text;
  String? imageUrl;
  String simulationId;
  String createdAt;
  String updatedAt;
  List<QuizOption> quizOptions;

  Question({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.simulationId,
    required this.createdAt,
    required this.updatedAt,
    required this.quizOptions,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      text: json['text'],
      imageUrl: json['imageUrl'],
      simulationId: json['simulationId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      quizOptions: List<QuizOption>.from(
        json['quizOptions'].map((option) => QuizOption.fromJson(option)),
      ),
    );
  }
}

class QuizOption {
  String id;
  String text;
  bool isCorrect;
  String questionId;
  String createdAt;
  String updatedAt;

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
