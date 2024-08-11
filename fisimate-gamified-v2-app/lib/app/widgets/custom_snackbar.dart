import 'package:fisimate/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorSnackbar({required String title, required String message}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: CustomColor.errorColor,
    colorText: CustomColor.whiteColor,
    margin: EdgeInsets.all(10),
  );
}

showSuccessSnackbar({required String title, required String message}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: CustomColor.successColor,
    colorText: CustomColor.whiteColor,
    margin: EdgeInsets.all(10),
  );
}
