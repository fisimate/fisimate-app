import 'package:fisimate_flutter_app/app/data/responses/simulation/quiz/question_response.dart';
import 'package:fisimate_flutter_app/app/modules/main/simulation/simulation_content/controllers/simulation_content_controller.dart';
import 'package:fisimate_flutter_app/app/theme/colors.dart';
import 'package:fisimate_flutter_app/app/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SimulationQuizSectionView extends GetView<SimulationContentController> {
  const SimulationQuizSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 4; i++)
                _buildQuizNumber(
                  number: i + 1,
                  isActive: controller.currentQuizIndex.value == i,
                  isLastItem: i == 3,
                  answered: controller.answeredIndex.contains(i),
                ),
            ],
          ),
        ),
        const Gap(26),
        Obx(
          () => Expanded(
            child: PageView(
              controller: controller.quizContentController,
              onPageChanged: (int index) {
                controller.currentQuizIndex.value = index;
              },
              children: <Widget>[
                ...controller.questions.map(
                  (Question question) {
                    final int questionIndex =
                        controller.questions.indexOf(question);
                    return _buildQuizContent(
                      questionIndex: questionIndex,
                      question: question,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _buildQuizContent({
    required int questionIndex,
    required Question question,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            question.text,
            style: bodyRegular.copyWith(
              fontSize: 14,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Obx(
            () {
              return Column(
                children: <Widget>[
                  for (int i = 0; i < 4; i++)
                    Column(
                      children: [
                        _buildAnswerButton(
                          questionAlphabet: controller.optionsAlphabet[i],
                          isSelected: controller.answers.any((Answer answer) =>
                              answer.quizIndex == questionIndex &&
                              answer.answerIndex == i),
                          onPressed: () {
                            controller.addOrChangeAnswer(
                              Answer(
                                quizIndex: questionIndex,
                                answerIndex: i,
                              ),
                            );
                          },
                        ),
                        const Gap(
                          10,
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  ElevatedButton _buildAnswerButton({
    required String questionAlphabet,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected == true
            ? CustomColor.seaBlueColor
            : CustomColor.whiteColor,
        elevation: 0,
        side: BorderSide(
          color: CustomColor.blueColor,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: isSelected == true
                  ? CustomColor.blueColor
                  : CustomColor.whiteColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: CustomColor.lightBlueColor,
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              questionAlphabet,
              style: bodyRegular.copyWith(
                fontSize: 14,
                color: isSelected == true
                    ? CustomColor.whiteColor
                    : CustomColor.blackColor,
              ),
            ),
          ),
          const Gap(10),
          Text(
            "Lorem ipsum dolor",
            style: bodyRegular.copyWith(
              fontSize: 14,
              color: CustomColor.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildQuizNumber({
    required int number,
    required bool isActive,
    required bool? isLastItem,
    required bool answered,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isActive == true
            ? CustomColor.blueColor
            : answered == true
                ? CustomColor.seaBlueColor
                : CustomColor.whiteColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: CustomColor.bankRumus,
        ),
      ),
      padding: const EdgeInsets.all(16),
      margin: isLastItem == true
          ? const EdgeInsets.only(right: 0)
          : const EdgeInsets.only(right: 10),
      child: Text(
        number.toString(),
        style: bodyRegular.copyWith(
          color:
              isActive == true ? CustomColor.whiteColor : CustomColor.bankRumus,
          fontSize: 16,
        ),
      ),
    );
  }
}
