import 'package:fisimate/app/helpers/asset_helper.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:fisimate/app/widgets/custom_simulation_navigator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../controllers/simulation_result_controller.dart';

class SimulationResultView extends GetView<SimulationResultController> {
  const SimulationResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColor.bankRumus,
        centerTitle: true,
        title: Text(
          "Hasil",
          style: headingBold.copyWith(
            color: CustomColor.whiteColor,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: CustomSize.maxHeight * 0.40,
            child: Stack(
              children: <Widget>[
                Container(
                  height: CustomSize.maxHeight * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(50),
                    ),
                    gradient: RadialGradient(
                      radius: 0.4,
                      colors: [
                        CustomColor.blueColor,
                        CustomColor.bankRumus,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Selamat!",
                          style: subHeadingMedium.copyWith(
                            color: CustomColor.whiteColor,
                          ),
                        ),
                        Text(
                          controller.quizScore.toString(),
                          style: titleBold.copyWith(
                            color: CustomColor.whiteColor,
                            fontSize: 86,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  width: CustomSize.maxWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ResultItem(
                            value: controller.notAnsweredQuestions.toString(),
                            label: "Tidak Terjawab",
                            color: CustomColor.blueColor,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: ResultItem(
                            value: controller.answeredQuestions.toString(),
                            label: "Terjawab",
                            color: CustomColor.lightBlueColor,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Obx(
                            () => ResultItem(
                              value: controller.wrongAnswers.toString(),
                              label: "Jawaban Salah",
                              color: CustomColor.errorColor,
                            ),
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Obx(
                            () => ResultItem(
                              value: controller.correctAnswers.toString(),
                              label: "Jawaban Benar",
                              color: CustomColor.successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(30),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/images/leader_board.png",
                  height: 30,
                ),
                const Gap(6),
                Text("Leader Board", style: headingMedium),
                const Gap(12),
                Expanded(
                  child: Divider(
                    color: CustomColor.blueColor,
                    thickness: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Obx(
                () {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        for (var item in controller.leaderboardData)
                          LeaderBoardItem(
                            index: controller.leaderboardData.indexOf(item) + 1,
                            imageUrl: item.user.profilePicture,
                            name: item.user.fullname ?? "Tidak Diketahui",
                            score: item.sum.score.toString(),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomSimulationNavigator.onResultPage(
        currentSectionIndex: 0,
        onNextPressed: () => controller.moveToQuizReview(),
        onBackPressed: () => Get.offAllNamed(
          Routes.MAIN,
        ),
      ),
    );
  }
}

class LeaderBoardItem extends StatelessWidget {
  const LeaderBoardItem({
    super.key,
    required this.index,
    this.imageUrl,
    required this.name,
    required this.score,
  });

  final int index;
  final String? imageUrl;
  final String name;
  final String score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      margin: const EdgeInsets.only(
        left: 10,
        bottom: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: CustomColor.greyColor.withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Image.asset(
                  matchLeaderBoardIconByRank(index),
                  height: 25,
                ),
                const Gap(10),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageUrl == ''
                          ? const AssetImage(
                                  "assets/images/default/default_profile_photo.png",
                                )
                                as ImageProvider
                          : NetworkImage(
                              imageUrl!,
                            ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: CustomColor.whiteColor,
                      width: 1,
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: CustomColor.greyColor.withValues(alpha: 0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Text(
                    name,
                    style: subHeadingMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/icons/regular-medal.png",
                  height: 20,
                ),
                const Gap(5),
                Text(
                  "Score $score",
                  style: poppinsRegular.copyWith(
                    color: CustomColor.blackColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResultItem extends StatelessWidget {
  const ResultItem({
    super.key,
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.1,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CustomColor.greyColor.withValues(alpha: 0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                value,
                style: titleBold.copyWith(
                  color: color,
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: Text(
                  label,
                  style: bodyRegular.copyWith(
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
