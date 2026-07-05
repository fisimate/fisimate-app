import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/helpers/form_validation_helper.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/edit_password_controller.dart';

class EditPasswordView extends GetView<EditPasswordController> {
  const EditPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: CustomColor.whiteColor,
          appBar: AppBar(
            backgroundColor: CustomColor.whiteColor,
            title: Text(
              'Ubah Kata Sandi',
              style: headingBold,
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
                  ),
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: Column(
            children: <Widget>[
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: <Widget>[
                      GetBuilder<EditPasswordController>(
                        id: 'old_password',
                        builder: (EditPasswordController controller) {
                          return _buildEditPasswordItem(
                            label: "Kata Sandi Lama",
                            hint: "Masukkan kata sandi lama",
                            controller: controller.oldPasswordController,
                            focusNode: controller.oldPasswordFocusNode,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Tidak boleh kosong";
                              } else if (value.length < 8) {
                                return "Minimal 8 karakter";
                              }
                              return null;
                            },
                            obscureText: controller.isOldPasswordObscure,
                            onTap: () => controller.toggleIsOldPasswordObscure,
                          );
                        },
                      ),
                      const Gap(20),
                      _buildEditPasswordItem(
                        label: "Kata Sandi Baru",
                        hint: "Masukkan kata sandi baru",
                        controller: controller.newPasswordController,
                        focusNode: controller.newPasswordFocusNode,
                        validator: (String? value) {
                          return ValidationHelper.validatePassword(value!);
                        },
                        obscureText: controller.isNewPasswordObscure,
                        onTap: () => controller.toggleIsNewPasswordObscure,
                      ),
                      const Gap(20),
                      _buildEditPasswordItem(
                        label: "Konfirmasi Kata Sandi",
                        hint: "Masukkan konfirmasi kata sandi",
                        controller: controller.confirmPasswordController,
                        focusNode: controller.confirmPasswordFocusNode,
                        validator: (String? value) {
                          return ValidationHelper.validateConfirmPassword(
                            confirmPassword: value!,
                            password: controller.newPasswordController.text,
                          );
                        },
                        obscureText: controller.isConfirmPasswordObscure,
                        onTap: () => controller.toggleIsConfirmPasswordObscure,
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: CustomFilledButton(
              text: "Simpan",
              onTap: () {
                if (controller.formKey.currentState != null && controller.formKey.currentState!.validate()) {
                  controller.changePassword();
                }
              },
            ),
          ),
        ),
        GetBuilder<EditPasswordController>(
          builder: (EditPasswordController controller) {
            if (controller.resultState == ResultState.loading) {
              return Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: CustomColor.bankRumus,
                    backgroundColor: CustomColor.whiteColor,
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  Container _buildEditPasswordItem({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    required bool obscureText,
    FocusNode? focusNode,
    VoidCallback? onTap,
  }) {
    onTap ??= () {};
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: CustomColor.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: CustomColor.blackColor.withValues(alpha: 0.06),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color: CustomColor.blackColor.withValues(alpha: 0.10),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: bodyRegular.copyWith(
              color: CustomColor.greyColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  obscureText: obscureText,
                  controller: controller,
                  focusNode: focusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validator,
                  style: bodySemiBold.copyWith(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: hint,
                    hintStyle: bodySemiBold.copyWith(
                      fontSize: 16,
                      color: CustomColor.darkGreyColor,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    suffix: GestureDetector(
                      onTap: onTap,
                      child: Icon(
                        Icons.visibility,
                        color: CustomColor.darkGreyColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
