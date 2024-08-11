class GeneratedPhycsicsExam {
  final String question;
  final List<Option> optionList;
  final String rightAnswer;
  final String explanation;

  GeneratedPhycsicsExam({
    required this.question,
    required this.optionList,
    required this.rightAnswer,
    required this.explanation,
  });

  factory GeneratedPhycsicsExam.fromJson(Map<String, dynamic> json) {
    return GeneratedPhycsicsExam(
      question: json['questions'],
      optionList: List<Option>.from(
        json['options'].map(
          (x) => Option.fromJson(x),
        ),
      ),
      rightAnswer: json['answer'],
      explanation: json['explanation'],
    );
  }
}

class Option {
  final String option;
  final bool correct;

  Option({
    required this.option,
    required this.correct,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      option: json['option'],
      correct: json['correct'],
    );
  }
}