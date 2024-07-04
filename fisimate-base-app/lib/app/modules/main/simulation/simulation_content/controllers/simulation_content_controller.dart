import 'package:fisimate/app/config/services/question_api_service.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/question_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/simulation_material_section_view.dart';
import '../views/simulation_quiz_section_view.dart';
import '../views/simulation_simulation_section_view.dart';
import 'package:fisimate/app/models/simulation.dart' as simulation_model;


class SimulationContentController extends GetxController {
  PageController pageController = PageController();
  PageController quizContentController = PageController();
  RxInt currentIndex = 0.obs;
  RxInt currentQuizIndex = 0.obs;
  RxList<Question> questions = <Question>[].obs;

  List<String> optionsAlphabet = <String>['A', 'B', 'C', 'D'];
  RxList<int> answeredIndex = <int>[].obs;
  RxList<Answer> answers = <Answer>[].obs;
  List<Widget> pages = const <Widget>[
    SimulationMaterialSectionView(),
    SimulationSimulationSectionView(),
    SimulationQuizSectionView(),
  ];

  @override
  void onReady() async {
    questions.value = await getQuestions();
    super.onReady();
  }

  Future<List<Question>> getQuestions() async {
    simulation_model.Simulation simulation = Get.arguments;
    final QuestionResponse response =
        await QuestionApiService().getAllQuestionsById(
      accessToken: await StorageService.getAccessToken(),
      simulationId: simulation.id!,
    );
    return response.data.questions;
  }

  void addOrChangeAnswer(Answer answer) {
    if (answeredIndex.contains(answer.quizIndex)) {
      final int index = answeredIndex.indexOf(answer.quizIndex);
      answers[index] = answer;
    } else {
      answeredIndex.add(answer.quizIndex);
      answers.add(answer);
    }
  }

  void removeAnswer(int selectedAnswerIndex) {
    final int index = answeredIndex.indexOf(currentQuizIndex.value);
    answers.removeAt(index);
    answeredIndex.remove(currentQuizIndex.value);
  }

  void changePage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void changeQuizIndex(int index) {
    quizContentController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    quizContentController.dispose();
    super.onClose();
  }
}

class Answer {
  int quizIndex;
  int answerIndex;

  Answer({
    required this.quizIndex,
    required this.answerIndex,
  });
}
