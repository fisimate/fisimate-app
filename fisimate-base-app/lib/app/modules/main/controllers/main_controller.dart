import 'package:fisimate/app/modules/chatbot/views/chatbot_view.dart';
import 'package:fisimate/app/modules/main/home/views/home_view.dart';
import 'package:fisimate/app/modules/main/simulation/views/simulation_view.dart';
import 'package:fisimate/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  List<Widget> pages = [
    const HomeView(),
    const SimulationView(),
    const ChatbotView(),
    const ProfileView(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }

  final count = 0.obs;

  void increment() => count.value++;
}
