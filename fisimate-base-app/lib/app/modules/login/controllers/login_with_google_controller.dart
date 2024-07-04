import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginWithGoogleController extends GetxController {
  var googleAuthUrl = '';
  @override
  void onInit() {
    final argument = Get.arguments;
    if (argument != null) {
      googleAuthUrl = argument as String;
      debugPrint('Google Auth Url from Login View: $googleAuthUrl');
    }
    super.onInit();
  }
}
