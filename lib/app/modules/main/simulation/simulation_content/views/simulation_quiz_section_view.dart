import 'package:fisimate/app/modules/main/simulation/simulation_content/controllers/simulation_content_controller.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';
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
            children: <Widget>[
              for (int i = 0; i < 4; i++)
                _buildQuizNumber(
                  number: i + 1,
                  isLastItem: i == 3,
                  isActive: i == controller.currentQuizIndex.value,
                ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            controller: controller.quizContentController,
            onPageChanged: (int index) {
              controller.currentQuizIndex.value = index;
            },
            children: <Widget>[
              _buildQuizContent(),
              _buildQuizContent(),
              _buildQuizContent(),
              _buildQuizContent(),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildQuizContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec odio nec nisl tincidunt tincidunt, ut fermentum nunc semper ut nunc semper. Nulla nec odio nec nisl tincidunt tincidunt, ut fermentum nunc semper ut nunc semper. Nulla nec odio nec nisl tincidunt tincidunt, ut fermentum nunc semper ut nunc semper. Nulla nec odio nec nisl tincidunt tincidunt, ut fermentum nunc semper ut nunc semper.",
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
          child: Column(
            children: <Widget>[
              _buildAnswerButton(),
              _buildAnswerButton(),
              _buildAnswerButton(),
              _buildAnswerButton(),
            ],
          ),
        ),
      ],
    );
  }

  ElevatedButton _buildAnswerButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColor.whiteColor,
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
              shape: BoxShape.circle,
              border: Border.all(
                color: CustomColor.bankRumus,
              ),
            ),
            padding: const EdgeInsets.all(5),
            child: Text(
              "A",
              style: bodyRegular.copyWith(
                fontSize: 14,
                color: CustomColor.blackColor,
              ),
            ),
          ),
          const SizedBox(width: 10),
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
  }) {
    return Container(
      decoration: BoxDecoration(
        color:
            isActive == true ? CustomColor.bankRumus : CustomColor.whiteColor,
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
