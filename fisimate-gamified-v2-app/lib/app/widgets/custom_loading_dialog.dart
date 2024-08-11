import 'package:fisimate/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoadingDialog() {
  Get.dialog(
    Center(
      child: CircularProgressIndicator(
        color: CustomColor.bankRumus,
        backgroundColor: CustomColor.whiteColor,
      ),
    ),
  );
}
