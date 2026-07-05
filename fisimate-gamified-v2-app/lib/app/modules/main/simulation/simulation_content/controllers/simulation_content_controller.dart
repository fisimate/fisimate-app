import 'package:fisimate/app/config/services/question_api_service.dart';
import 'package:fisimate/app/config/services/simulation_api_service.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/get_simulation_material_response.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/post_answer_request.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/post_answer_response.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/question_response.dart';
import 'package:fisimate/app/data/responses/simulation/simulation/get_all_simulation.dart';
import 'package:fisimate/app/modules/game/controllers/game_controller.dart';
import 'package:fisimate/app/modules/main/simulation/controllers/simulation_controller.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/simulation_material_section_view.dart';
import '../views/simulation_quiz_section_view.dart';
import '../views/simulation_simulation_section_view.dart';
// import 'package:fisimate/app/models/simulation.dart' as simulation_model;

class SimulationContentController extends GetxController {
  // TO HANDLE THE PAGE VIEW
  PageController pageController = PageController();
  PageController quizContentController = PageController();

  RxInt currentIndex = 0.obs;
  RxInt currentQuizIndex = 0.obs;

  List<Widget> pages = const <Widget>[
    SimulationMaterialSectionView(),
    SimulationSimulationSectionView(),
    SimulationQuizSectionView(),
  ];

  final RxList<Question> _questions = <Question>[].obs;
  List<Question> get questions => _questions;

  List<String> optionsAlphabet = <String>['A', 'B', 'C', 'D'];

  RxList<int> answeredIndex = <int>[].obs;
  RxList<AnswerItem> answers = <AnswerItem>[].obs;

  @override
  void onReady() async {
    _questions.value = await getQuestions();
    await getSimulationMaterial();
    updateSimulationProgress(1);
    SimulationController simulationController = Get.find<SimulationController>();
    simulationController.getAllSimulations();
    super.onReady();
  }

  RxString pdfFilePath = ''.obs;

  Future<void> getSimulationMaterial() async {
    SimulationDTO simulation = Get.arguments['simulation'];

    final SimulationApiService simulationApiService = SimulationApiService();
    final response = await simulationApiService.getSimulationMaterialById(
      accessToken: await StorageService.getAccessToken() ?? '',
      simulationId: simulation.id,
    );

    if (response is GetSimulationMaterialResponse) {
      print(response.data.filePath);
      pdfFilePath.value = response.data.filePath ?? '';
    } else {
      pdfFilePath.value = 'error';
    }

    update(['pdf_viewer']);
  }

  Future<List<Question>> getQuestions() async {
    SimulationDTO simulation = Get.arguments['simulation'];
    final QuestionResponse response = await QuestionApiService().getAllQuestionsById(
      accessToken: await StorageService.getAccessToken() ?? '',
      simulationId: simulation.id,
    );
    return response.data.questions;
  }

  Future<void> submitAnswers() async {
    final List<AnswerItem> answersMap = <AnswerItem>[];
    for (int i = 0; i < answers.length; i++) {
      answersMap.add(
        AnswerItem(
          questionId: answers[i].questionId,
          selectedOptionId: answers[i].selectedOptionId,
        ),
      );
    }

    final SimulationDTO simulation = Get.arguments['simulation'];

    final PostAnswerResponse postAnswerResponse = await QuestionApiService().submitAnswers(
      accessToken: await StorageService.getAccessToken() ?? '',
      simulationId: simulation.id,
      answers: answersMap,
    );

    Get.offNamed(
      Routes.SIMULATION_RESULT,
      arguments: {
        'simulationId': simulation.id,
        'postAnswerResponse': postAnswerResponse,
      },
    );
  }

  void addOrChangeAnswer(AnswerItem answer) {
    if (answeredIndex.contains(currentQuizIndex.value)) {
      final int index = answeredIndex.indexOf(currentQuizIndex.value);
      answers[index] = answer;
    } else {
      answers.add(answer);
      answeredIndex.add(currentQuizIndex.value);
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

    updateSimulationProgress(index + 1);
    SimulationController simulationController = Get.find<SimulationController>();
    simulationController.getAllSimulations();

    print(Get.arguments['gameScene']);
    GameController gameController = Get.find<GameController>();
    gameController.setScene(Get.arguments['gameScene']);
  }

  Future<void> updateSimulationProgress(int progress) async {
    final SimulationDTO simulation = Get.arguments['simulation'];
    await SimulationApiService().postSimulationProgressById(
      accessToken: await StorageService.getAccessToken() ?? '',
      simulationId: simulation.id,
      progress: progress,
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
