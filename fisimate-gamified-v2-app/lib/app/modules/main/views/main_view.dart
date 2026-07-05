import 'package:fisimate/app/modules/chatbot/controllers/chatbot_controller.dart';
import 'package:fisimate/app/modules/main/views/widgets/custom_bottom_navbar.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    ChatbotController chatbotController = Get.find<ChatbotController>();
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Obx(
            () => controller.pages[controller.currentIndex.value],
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        ),
        Obx(
          () {
            return chatbotController.isQuizAnswerAlertDisplayed
                ? Animate(
                    effects: const [
                      FadeEffect(
                        duration: Duration(seconds: 1),
                        curve: Curves.easeInOut,
                      ),
                    ],
                    onComplete: (AnimationController controller) {
                      Future.delayed(const Duration(seconds: 1), () {
                        controller.reverse();
                      });
                    },
                    child: Container(
                      color: chatbotController.isQuizAnswerCorrect
                          ? CustomColor.greenColor.withValues(alpha: 0.4)
                          : CustomColor.errorColor.withValues(alpha: 0.4),
                      height: CustomSize.maxHeight,
                      width: CustomSize.maxWidth,
                      child: Center(
                        child: Image.asset(
                          chatbotController.isQuizAnswerCorrect
                              ? 'assets/images/quiz/quiz_correct.png'
                              : 'assets/images/quiz/quiz_wrong.png',
                          width: 200,
                        ),
                      ),
                    ),
                  )
                : Container();
          },
        ),
      ],
    );
  }
}
