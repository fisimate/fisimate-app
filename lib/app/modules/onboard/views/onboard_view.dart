import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:fisimate/app/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(CustomSize.marginLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/onboard.png",
              width: Get.width / 2,
              height: Get.height / 3,
            ),
            const SizedBox(height: 30),
            Text(
              "Selamat datang di Labirin!",
              style: poppinsMedium.copyWith(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Aplikasi simulasi percobaan fisika pada laboratorium menyediakan pengalaman interaktif dan realistis bagi pengguna untuk menjalani eksperimen fisika tanpa kehadiran fisik di laboratorium",
              style: poppinsRegular.copyWith(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            CustomFilledButton(
              height: 55,
              color: CustomColor.purpleColor,
              radius: 16,
              text: "Mulai",
              onTap: () {
                Get.offNamed('/login');
              },
            )
          ],
        ),
      ),
    );
  }
}
