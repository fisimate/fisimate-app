import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/onboard.png",
            scale: 0.5,
          ),
          const SizedBox(height: 50),
          Text(
            "Selamat datang di Labirin !",
            style: poppinsMedium.copyWith(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            "Aplikasi simulasi percobaan fisika pada laboratorium\nmenyediakan pengalaman interaktif dan realistis\nbagi pengguna untuk menjalani eksperimen\nfisika tanpa kehadiran fisik di laboratorium",
            style: poppinsRegular.copyWith(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),
          const Spacer(),
          const CustomFilledButton(
            text: "Mulai",
          )
        ],
      ),
    );
  }
}
