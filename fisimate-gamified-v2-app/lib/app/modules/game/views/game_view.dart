import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../controllers/game_controller.dart';

class GameView extends GetView<GameController> {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GetBuilder<GameController>(
          builder: (GameController gameController) {
            return Stack(
              children: <Widget>[
                // Unity simulation is disabled for now, see docs/MIGRATION.md.
                Container(
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: Text(
                    'Simulasi 3D belum tersedia',
                    style: poppinsBold.copyWith(color: Colors.white),
                  ),
                ),
                if (!gameController.isGameLoaded.value == true)
                  Stack(
                    children: <Widget>[
                      Shimmer(
                        color: Colors.blue,
                        colorOpacity: 0.1,
                        duration: const Duration(seconds: 3),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(14),
                          ),
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(
                              color: CustomColor.bankRumus,
                              strokeCap: StrokeCap.round,
                              strokeWidth: 5,
                            ),
                            const Gap(20),
                            Text(
                              'Loading...',
                              style: poppinsBold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
