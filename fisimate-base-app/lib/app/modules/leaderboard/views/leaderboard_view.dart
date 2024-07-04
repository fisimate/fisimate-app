import 'package:fisimate/app/modules/leaderboard/widgets/custom_leaderboard_tile.dart';
import 'package:fisimate/app/modules/leaderboard/widgets/top_leaderboard_card.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/leaderboard_controller.dart';

class LeaderboardView extends GetView<LeaderboardController> {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
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
          ];
        },
        body: GetBuilder<LeaderboardController>(
            init: LeaderboardController(),
            id: 'leaderboard',
            builder: (builder) {
              return ListView(
                children: <Widget>[
                  const Gap(20.0),
                  Stack(
                    children: <Widget>[
                      SizedBox(
                        height: 250,
                        child: FutureBuilder(
                          future: Future.delayed(
                            const Duration(milliseconds: 100),
                          ),
                          builder: (context, snaphot) {
                            return PageView.builder(
                              controller: controller.pageController,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return AnimatedBuilder(
                                  animation: controller.pageController,
                                  builder: (context, child) {
                                    double value = 1.0;
                                    if (controller.pageController.position
                                        .haveDimensions) {
                                      value = controller.pageController.page! -
                                          index;
                                      value = (1 - (value.abs() * 0.3))
                                          .clamp(0.5, 1.0);
                                    } else {
                                      value = (index == 0) ? 1.0 : 0.5;
                                    }

                                    double scaleValue =
                                        Curves.ease.transform(value);

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
                                            alignment: index ==
                                                    controller
                                                        .pageController.page
                                                        ?.round()
                                                ? Alignment.topCenter
                                                : Alignment.center,
                                            child: TopLeaderboardCard(
                                              position: index + 1,
                                              name: 'John Doe',
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Positioned(
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
                      )
                    ],
                  ),
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
    );
  }
}
