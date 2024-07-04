import 'package:fisimate_flutter_app/app/theme/colors.dart';
import 'package:fisimate_flutter_app/app/theme/fonts.dart';
import 'package:fisimate_flutter_app/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardController());
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(CustomSize.marginLarge),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/onboarding/onboarding_1.png",
                  width: Get.width * 0.7,
                ),
                const Gap(20),
                Text(
                  "Selamat datang di FISIMATE!",
                  style: poppinsSemiBold.copyWith(
                    fontSize: 22,
                    color: CustomColor.lightBlueColor50,
                  ),
                ),
                const Gap(12),
                Text(
                  "Platform pembelajaran dengan teknologi Generative Artificial Intelligence untuk membantu kamu berkenalan dengan fisika!",
                  style: poppinsMedium.copyWith(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 26,
              child: ElevatedButton(
                onPressed: () => controller.navigate(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.blueColor,
                  foregroundColor: CustomColor.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  minimumSize: Size(Get.width - 40, kMinInteractiveDimension),
                ),
                child: Text(
                  "Mulai",
                  style: headingBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
