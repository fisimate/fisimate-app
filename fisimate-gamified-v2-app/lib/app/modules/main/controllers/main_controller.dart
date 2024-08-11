import 'package:fisimate/app/modules/chatbot/controllers/chatbot_controller.dart';
import 'package:fisimate/app/modules/chatbot/views/chatbot_view.dart';
import 'package:fisimate/app/modules/main/home/views/home_view.dart';
import 'package:fisimate/app/modules/main/simulation/controllers/simulation_controller.dart';
import 'package:fisimate/app/modules/main/simulation/views/simulation_view.dart';
import 'package:fisimate/app/modules/profile/views/profile_view.dart';
import 'package:fisimate/app/widgets/base_dialog.dart';
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

  void changePage(int index) async {
    clearTextEditingControllers();
    if (await checkIndex(index)) {
      currentIndex.value = index;
    }
  }

  ChatbotController get chatbotController => Get.find<ChatbotController>();
  RxBool isChatMessagesEmpty = true.obs;

  Future<bool> checkIndex(int index) async {
    isChatMessagesEmpty.value = chatbotController.chatMessages.isEmpty;
    if (currentIndex.value == 2 && index != 2 && !isChatMessagesEmpty.value) {
      chatbotController.unFocus();
      bool? result = await Get.dialog<bool>(
        BaseDialog(
          text: "Aksi Anda akan menghapus riwayat percakapan Anda",
          onConfirm: () {
            clearChatMessages();
            Get.back(result: true);
          },
          onCancel: () {
            Get.back(result: false);
          },
        ),
      );
      return result ?? false;
    }
    return true;
  }

  void clearTextEditingControllers() {
    if (currentIndex.value == 1) {
      Get.find<SimulationController>().searchController.clear();
      Get.find<SimulationController>().clearSearch();
    }
  }

  void clearChatMessages() {
    if (currentIndex.value == 2) {
      Get.find<ChatbotController>().chatMessages.clear();
    }
  }
}
