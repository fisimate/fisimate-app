import 'package:fisimate/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.create(() => SplashController());
    final SplashController splashController = Get.find();
    return Scaffold(
      body: Center(
        child: Obx(
          () => AnimatedBuilder(
              animation: splashController.animationController!,
              builder: (context, child) {
                return Container(
                  width: controller.sizeAnimation?.value ?? 0.0,
                  height: controller.sizeAnimation?.value ?? 0.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        controller.radiusAnimation?.value ?? 0.0),
                    color: CustomColor.purpleColor,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
