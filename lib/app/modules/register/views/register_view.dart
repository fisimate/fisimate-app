import 'package:fisimate/app/helpers/form_validation_helper.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:fisimate/app/widgets/custom_asset_button.dart';
import 'package:fisimate/app/widgets/custom_filled_button.dart';
import 'package:fisimate/app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomSize.marginLarge,
          ),
          child: Obx(
            () => Form(
              key: controller.formKey,
              child: Column(children: [
                Gap(
                  MediaQuery.of(context).padding.top,
                ),
                SizedBox(
                  width: CustomSize.maxWidth,
                  child: Text(
                    'Selamat Datang!',
                    style: poppinsBold.copyWith(fontSize: 28),
                    textAlign: TextAlign.start,
                  ),
                ),
                const Gap(27.0),
                CustomTextField(
                  controller: controller.nameController,
                  hintText: 'Nama Lengkap',
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    return ValidationHelper.validateName(value!);
                  },
                ),
                const Gap(20.0),
                CustomTextField(
                  controller: controller.nomorIndukController,
                  hintText: 'Nomor Induk Siswa',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return ValidationHelper.validateNomorInduk(value!);
                  },
                ),
                const Gap(20.0),
                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'Email',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return ValidationHelper.validateEmail(value!);
                  },
                ),
                const Gap(20.0),
                CustomTextField(
                  controller: controller.passwordController,
                  hintText: 'Password',
                  obscureText: controller.isObscurePassword.value,
                  textInputAction: TextInputAction.next,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.toggleObscurePassword();
                    },
                    icon: Icon(
                      controller.isObscurePassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: CustomColor.darkGreyColor,
                    ),
                  ),
                  validator: (value) {
                    return ValidationHelper.validatePassword(value!);
                  },
                ),
                const Gap(20.0),
                CustomTextField(
                  controller: controller.confirmPasswordController,
                  hintText: 'Konfirmasi Password',
                  obscureText: controller.isObscurePasswordConf.value,
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.toggleObscurePasswordConf();
                    },
                    icon: Icon(
                      controller.isObscurePasswordConf.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: CustomColor.darkGreyColor,
                    ),
                  ),
                  validator: (value) {
                    return ValidationHelper.validateConfirmPassword(
                      confirmPassword: value!,
                      password: controller.passwordController.text,
                    );
                  },
                ),
                const Gap(17.0),
                _buildAlreadyHaveAccountComponents(),
                const Gap(60.0),
                CustomFilledButton(
                  text: 'Daftar',
                  onTap: () {
                    if (controller.formKey.currentState != null &&
                        controller.formKey.currentState!.validate()) {
                      FocusNode().unfocus();
                      controller.registerWithEmail();
                    }
                  },
                ),
                const Gap(23.0),
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
                Gap(
                  MediaQuery.of(context).padding.top,
                ),
              ]),
            ),
          ),
        )),
      ),
    );
  }
}

Row _buildAlreadyHaveAccountComponents() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Sudah punya akun?',
        style: subHeadingMedium.copyWith(
          color: const Color(0xff6E7191),
        ),
      ),
      TextButton(
        onPressed: () {
          final controller = Get.find<RegisterController>();
          controller.nameController.clear();
          controller.nomorIndukController.clear();
          controller.emailController.clear();
          controller.passwordController.clear();
          controller.confirmPasswordController.clear();

          Get.offAllNamed(Routes.LOGIN);
        },
        child: Text(
          'Masuk',
          style: subHeadingBold.copyWith(
            color: const Color(0xff6E7191),
            decoration: TextDecoration.underline,
          ),
        ),
      )
    ],
  );
}
