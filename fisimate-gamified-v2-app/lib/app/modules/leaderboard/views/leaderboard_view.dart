import 'package:fisimate/app/modules/leaderboard/widgets/custom_leaderboard_tile.dart';
import 'package:fisimate/app/modules/leaderboard/widgets/top_leaderboard_card.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../data/responses/dashboard/get_leaderboard.dart';
import '../controllers/leaderboard_controller.dart';

class LeaderboardView extends GetView<LeaderboardController> {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.leaderboard,
        title: Text(
          'Leader Board',
          style: headingBold.copyWith(color: CustomColor.whiteColor),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: CircleAvatar(
            radius: 16,
            backgroundColor: CustomColor.whiteColor,
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Image.asset(
                'assets/icons/arrow-back.png',
                color: CustomColor.leaderboard,
              ),
            ),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: CustomColor.whiteColor,
      body: ListView(
        children: <Widget>[
          const Gap(20.0),
          Stack(
            children: <Widget>[
              SizedBox(
                height: 250,
                child: GetBuilder<LeaderboardController>(
                  id: 'topLeaderboard',
                  builder: (LeaderboardController controller) {
                    return PageView.builder(
                      controller: controller.pageController,
                      itemCount: controller.topLeaderboard.length,
                      itemBuilder: (context, index) {
                        if (controller.pageController.position.haveDimensions) {
                          return _buildTopLeaderBoard(
                            controller: controller,
                            index: index,
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    );
                  },
                ),
              ),
              GetBuilder<LeaderboardController>(
                  id: 'leaderboard_navigator',
                  builder: (LeaderboardController controller) {
                    if (controller.topLeaderboard.isEmpty) {
                      return const SizedBox.shrink();
                    } else {
                      return Positioned(
                        left: 0,
                        top: 60,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 80,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  controller.pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/arrow_left.svg",
                                  height: 40,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/arrow_right.svg",
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  })
            ],
          ),
          GetBuilder<LeaderboardController>(
            id: 'regularLeaderboard',
            builder: (LeaderboardController controller) {
              List<LeaderboardData> leaderboardData =
                  controller.regularLeaderboard;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0;
                        i < controller.regularLeaderboard.length;
                        i++)
                      CustomLeaderboardTile(
                        position: i + 4,
                        name: leaderboardData[i].user.fullname ?? '',
                        imageUrl: leaderboardData[i].user.profilePicture ?? '',
                        score: leaderboardData[i].sum.score,
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  AnimatedBuilder _buildTopLeaderBoard({
    required LeaderboardController controller,
    required int index,
  }) {
    return AnimatedBuilder(
      animation: controller.pageController,
      builder: (context, child) {
        double value = 1.0;
        if (controller.pageController.position.haveDimensions &&
            controller.pageController.position.hasPixels) {
          value = controller.pageController.page! - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.5, 1.0);
        } else {
          value = (index == 0) ? 1.0 : 0.5;
        }

        double scaleValue = Curves.ease.transform(value);

        return Center(
          child: Transform(
            transform: Matrix4.identity()
              ..scale(value)
              ..translate(
                (1 - scaleValue) * 50.0,
              ),
            alignment: Alignment.center,
            child: Opacity(
              opacity: value,
              child: Align(
                alignment: index == controller.pageController.page?.round()
                    ? Alignment.topCenter
                    : Alignment.center,
                child: TopLeaderboardCard(
                  position: index + 1,
                  name: controller.topLeaderboard[index].user.fullname ?? '',
                  imageUrl:
                      controller.topLeaderboard[index].user.profilePicture ??
                          '',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
