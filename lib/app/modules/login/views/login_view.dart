import 'package:fisimate/app/config/state/result_state.dart';
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
            child: Obx(
              () {
                if (controller.state == ResultState.loading) {
                  showLoadingDialog(context);
                  return Container();
                }
                return Form(
                  key: controller.formKey,
                  child: Column(children: [
                    SizedBox(
                      width: CustomSize.maxWidth,
                      child: Text(
                        'Selamat Datang Kembali!',
                        style: poppinsBold.copyWith(fontSize: 28),
                      ),
                    ),
                    const Gap(40.0),
                    CustomTextField(
                      hintText: 'Email',
                      controller: controller.emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return ValidationHelper.validateEmail(value!);
                      },
                    ),
                    const Gap(20.0),
                    CustomTextField(
                      hintText: 'Password',
                      controller: controller.passwordController,
                      obscureText: controller.isObscurePassword.value,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        return ValidationHelper.validatePassword(value!);
                      },
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
                    ),
                    const Gap(17.0),
                    _buildRegisterHereComponents(),
                    const Gap(60.0),
                    CustomFilledButton(
                      text: 'Masuk',
                      onTap: () {
                        if (controller.formKey.currentState != null &&
                            controller.formKey.currentState!.validate()) {
                          FocusNode().unfocus();
                          controller.loginWithEmail();
                        }
                      },
                    ),
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
                );
              },
            ),
          ),
        ),
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
          onPressed: () {
            controller.emailController.clear();
            controller.passwordController.clear();

            Get.offAllNamed(Routes.REGISTER);
          },
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

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        ),
      );
    },
  );
}
