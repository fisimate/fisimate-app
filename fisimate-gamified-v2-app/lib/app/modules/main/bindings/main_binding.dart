import 'package:fisimate/app/modules/chatbot/controllers/chatbot_controller.dart';
import 'package:fisimate/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
    Get.put(
      ProfileController(),
    );
    Get.put(
      ChatbotController(),
    );
  }
}
