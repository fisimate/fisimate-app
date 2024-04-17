import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimulationContentController extends GetxController {
  PageController pageController = PageController();
  PageController quizContentController = PageController();
  RxInt currentIndex = 0.obs;
  RxInt currentQuizIndex = 0.obs;

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
