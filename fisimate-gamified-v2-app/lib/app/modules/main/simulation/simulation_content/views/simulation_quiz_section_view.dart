import 'package:cached_network_image/cached_network_image.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/post_answer_request.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/question_response.dart';
import 'package:fisimate/app/modules/main/simulation/simulation_content/controllers/simulation_content_controller.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/widgets/custom_skeleton_widget.dart';
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
              for (int i = 0; i < controller.questions.length; i++)
                _buildQuizNumber(
                  number: i + 1,
                  isActive: controller.currentQuizIndex.value == i,
                  isLastItem: i == controller.questions.length - 1,
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

  SingleChildScrollView _buildQuizContent({
    required int questionIndex,
    required Question question,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (question.imageUrl != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: question.imageUrl!,
                  fit: BoxFit.fitHeight,
                  width: double.infinity,
                  height: 200,
                  placeholder: (context, url) {
                    return const CustomSkeletonWidget(
                      height: 200,
                    );
                  },
                ),
              ),
            ),
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
                    for (int i = 0;
                        i <
                            controller
                                .questions[questionIndex].quizOptions.length;
                        i++)
                      Column(
                        children: [
                          _buildAnswerButton(
                            questionAlphabet: controller.optionsAlphabet[i],
                            quizOption: controller
                                .questions[questionIndex].quizOptions[i],
                            isSelected: controller.answers.any(
                                (AnswerItem answer) =>
                                    answer.questionId ==
                                        controller.questions[questionIndex].id &&
                                    answer.selectedOptionId ==
                                        controller.questions[questionIndex]
                                            .quizOptions[i].id),
                            onPressed: () {
                              controller.addOrChangeAnswer(
                                AnswerItem(
                                  questionId:
                                      controller.questions[questionIndex].id,
                                  selectedOptionId: controller
                                      .questions[questionIndex].quizOptions[i].id,
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
      ),
    );
  }

  ElevatedButton _buildAnswerButton({
    required String questionAlphabet,
    required QuizOption quizOption,
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
          vertical: 10,
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
          Expanded(
            child: Text(
              quizOption.text,
              style: bodyRegular.copyWith(
                fontSize: 14,
                color: CustomColor.blackColor,
              ),
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
