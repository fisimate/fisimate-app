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
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(
      viewportFraction: 0.8,
      initialPage: 1,
    );
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
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
                        child: PageView(
                          controller: pageController,
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          padEnds: false,
                          pageSnapping: true,
                          children: controller.topLeaderboard
                              .map(
                                (e) => TopLeaderboardCard(
                                  position: e['position'],
                                  name: e['name'],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      // SizedBox(
                      //   height: 250,
                      //   child: PageView.builder(
                      //     controller: _pageController,
                      //     itemCount: 3,
                      //     itemBuilder: (context, index) {
                      //       return AnimatedBuilder(
                      //         animation: _pageController,
                      //         builder: (context, child) {
                      //           double value = 1.0;
                      //           if (_pageController.position.haveDimensions) {
                      //             value = _pageController.page! - index;
                      //             value =
                      //                 (1 - (value.abs() * 0.3)).clamp(0.5, 1.0);
                      //           } else {
                      //             value = (index == 0) ? 1.0 : 0.5;
                      //           }
                      //
                      //           double scaleValue = Curves.ease.transform(value);
                      //
                      //           return Center(
                      //             child: Transform(
                      //               transform: Matrix4.identity()
                      //                 ..scale(value)
                      //                 ..translate(
                      //                   (1 - scaleValue) * 50.0,
                      //                 ),
                      //               alignment: Alignment.center,
                      //               child: Opacity(
                      //                 opacity: value,
                      //                 child: Align(
                      //                   alignment: index ==
                      //                           _pageController.page?.round()
                      //                       ? Alignment.topCenter
                      //                       : Alignment.center,
                      //                   child: TopLeaderboardCard(
                      //                     position: index + 1,
                      //                     name: 'John Doe',
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           );
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                      Positioned(
                        top: 25,
                        right: 0,
                        left: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                    duration: const Duration(milliseconds: 300),
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
    );
  }
}
