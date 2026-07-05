import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:fisimate/app/widgets/custom_simulation_navigator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/simulation_content_controller.dart';

class SimulationContentView extends GetView<SimulationContentController> {
  const SimulationContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      appBar: AppBar(
        backgroundColor: CustomColor.whiteColor,
        centerTitle: true,
        title: Text(
          "Materi",
          style: headingBold,
        ),
        leading: IconButton(
          icon: CircleAvatar(
            radius: 16,
            backgroundColor: CustomColor.whiteColor,
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Image.asset('assets/icons/arrow-back.png'),
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Obx(
            () {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildItemContentIcon(
                    context: context,
                    iconPath: 'assets/images/bank_materi.png',
                    title: 'Materi',
                    isActive: controller.currentIndex.value >= 0,
                  ),
                  _buildItemContentDivider(context),
                  _buildItemContentIcon(
                    context: context,
                    iconPath: controller.currentIndex.value >= 1
                        ? 'assets/images/simulation_active.png'
                        : 'assets/images/simulation_inactive.png',
                    title: 'Percobaan',
                    isActive: controller.currentIndex.value >= 1,
                  ),
                  _buildItemContentDivider(context),
                  _buildItemContentIcon(
                    context: context,
                    iconPath: controller.currentIndex.value >= 2
                        ? 'assets/images/quiz_active.png'
                        : 'assets/images/quiz_inactive.png',
                    title: 'Kuis',
                    isActive: controller.currentIndex.value >= 2,
                  ),
                ],
              );
            },
          ),
          const Gap(CustomSize.marginLarge),
          Expanded(
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                controller.currentIndex.value = index;
              },
              children: controller.pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          return CustomSimulationNavigator(
            currentSectionIndex: controller.currentIndex.value,
            currentQuizIndex: controller.currentQuizIndex.value,
            quizLength: controller.questions.length,
            onNextPressed: () => controller.currentIndex.value == controller.pages.length - 1
                ? controller.currentQuizIndex.value == controller.questions.length - 1
                      ? controller.submitAnswers()
                      : controller.changeQuizIndex(
                          controller.currentQuizIndex.value + 1,
                        )
                : controller.changePage(
                    controller.currentIndex.value + 1,
                  ),
            onBackPressed: () => controller.currentIndex.value == 0
                ? Get.back()
                : controller.currentQuizIndex.value == 0
                ? controller.changePage(
                    controller.currentIndex.value - 1,
                  )
                : controller.changeQuizIndex(
                    controller.currentQuizIndex.value - 1,
                  ),
          );
        },
      ),
    );
  }

  Container _buildItemContentDivider(BuildContext context) {
    return Container(
      height: 4,
      width: MediaQuery.of(context).size.width / 6,
      decoration: BoxDecoration(
        color: const Color(0xFF0080FF),
        borderRadius: BorderRadius.circular(
          CustomSize.roundedLarge,
        ),
      ),
    );
  }

  SizedBox _buildItemContentIcon({
    required BuildContext context,
    required String iconPath,
    required String title,
    required bool isActive,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(iconPath),
                fit: BoxFit.contain,
                opacity: isActive ? 1 : 0.5,
              ),
            ),
          ),
          const Gap(5),
          Text(
            title,
            style: subHeadingMedium.copyWith(
              color: CustomColor.blueColor,
            ),
          ),
        ],
      ),
    );
  }
}
