import 'dart:math';

import 'package:fisimate/app/modules/leaderboard/widgets/custom_leaderboard_tile.dart';
import 'package:fisimate/app/modules/leaderboard/widgets/top_leaderboard_card.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/leaderboard_controller.dart';

class LeaderboardView extends GetView<LeaderboardController> {
  const LeaderboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageController = PageController(viewportFraction: 1, initialPage: 1);

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
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
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ];
          },
          body: GetBuilder<LeaderboardController>(
              init: LeaderboardController(),
              id: 'leaderboard',
              builder: (builder) {
                return ListView(
                  children: [
                    const Gap(20.0),
                    Stack(
                      children: [
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: PageView(
                            controller: pageController,
                            scrollDirection: Axis.horizontal,
                            clipBehavior: Clip.none,
                            padEnds: false,
                            pageSnapping: true,
                            children: controller.topLeaderboard
                                .map(
                                  (e) => Center(
                                    child: TopLeaderboardCard(
                                      position: e['position'],
                                      name: e['name'],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Positioned(
                          bottom: 25,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                icon: Image.asset(
                                  'assets/icons/arrow-back.png',
                                  color: CustomColor.leaderboard,
                                  width: 100,
                                ),
                              ),
                              Gap(CustomSize.maxWidth / 2.6),
                              IconButton(
                                onPressed: () {
                                  pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                icon: IconButton(
                                  onPressed: () {
                                    pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  icon: Transform.rotate(
                                    angle: pi,
                                    child: Image.asset(
                                      'assets/icons/arrow-back.png',
                                      color: CustomColor.leaderboard,
                                      width: 100,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Gap(80.0),
                    SingleChildScrollView(
                      child: Column(
                        children: controller.regularLeaderboard
                            .map(
                              (e) => CustomLeaderboardTile(
                                  position: e['position'],
                                  name: e['name'],
                                  imageUrl: 'assets/images/dummy_avatar.png',
                                  score: e['score']),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
