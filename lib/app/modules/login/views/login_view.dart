import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:fisimate/app/widgets/custom_filled_button.dart';
import 'package:fisimate/app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomSize.marginLarge,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(children: [
              Text(
                'Selamat Datang Kembali!',
                style: poppinsBold.copyWith(fontSize: 28),
              ),
              const Gap(40.0),
              const CustomTextField(
                hintText: 'Email',
                textInputAction: TextInputAction.next,
              ),
              const Gap(20.0),
              CustomTextField(
                hintText: 'Password',
                obscureText: true,
                textInputAction: TextInputAction.done,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.visibility,
                    color: CustomColor.darkGreyColor,
                  ),
                ),
              ),
              const Gap(17.0),
              _buildRegisterHereComponents(),
              const Gap(60.0),
              const CustomFilledButton(text: 'Masuk'),
              const Gap(105.0),
              Text(
                'Atau masuk menggunakan',
                style: subHeadingMedium.copyWith(
                  color: const Color(0xff6E7191),
                ),
              ),
              const Gap(13.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomAssetButton(
                    assetPath: 'assets/icons/google.png',
                  ),
                  Gap(18.0),
                  CustomAssetButton(
                    assetPath: 'assets/icons/facebook.png',
                  ),
                ],
              ),
            ]),
          ),
        )),
      ),
    );
  }

  Row _buildRegisterHereComponents() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Belum punya akun?',
          style: subHeadingMedium.copyWith(
            color: const Color(0xff6E7191),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Daftar di sini',
            style: subHeadingBold.copyWith(
              color: const Color(0xff6E7191),
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}

class CustomAssetButton extends StatelessWidget {
  final double? size;
  final String assetPath;
  const CustomAssetButton({
    super.key,
    this.size,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? CustomSize.maxHeight / 18,
      width: size ?? CustomSize.maxHeight / 18,
      decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 0,
              spreadRadius: 1,
              offset: Offset(0, 0),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 1,
              spreadRadius: -0.5,
              offset: Offset(0, 1),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 3,
              spreadRadius: -1.5,
              offset: Offset(0, 3),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 6,
              spreadRadius: -3,
              offset: Offset(0, 6),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 12,
              spreadRadius: -6,
              offset: Offset(0, 12),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 24,
              spreadRadius: -12,
              offset: Offset(0, 24),
            ),
          ]),
      child: Center(
        child: Image.asset(
          assetPath,
          height: 27,
          width: 27,
        ),
      ),
    );
  }
}
