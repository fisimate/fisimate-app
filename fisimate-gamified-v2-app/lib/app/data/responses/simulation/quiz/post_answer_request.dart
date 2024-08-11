class PostAnswerRequest {
  List<AnswerItem> responses;

  PostAnswerRequest({required this.responses});

  factory PostAnswerRequest.fromJson(Map<String, dynamic> json) {
    return PostAnswerRequest(
      responses: List<AnswerItem>.from(
        json['responses'].map((response) => AnswerItem.fromJson(response)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responses':
          List<dynamic>.from(responses.map((response) => response.toJson())),
    };
  }
}

class AnswerItem {
  String questionId;
  String selectedOptionId;

  AnswerItem({required this.questionId, required this.selectedOptionId});

  factory AnswerItem.fromJson(Map<String, dynamic> json) {
    return AnswerItem(
      questionId: json['questionId'],
      selectedOptionId: json['selectedOptionId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'selectedOptionId': selectedOptionId,
    };
  }
}
