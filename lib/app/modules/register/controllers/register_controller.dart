import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/helpers/connectivity_helper.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController nomorIndukController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isObscurePassword = true.obs;
  RxBool isObscurePasswordConf = true.obs;

  ResultState state = ResultState.loading;

  @override
  void onClose() {
    nameController.dispose();
    nomorIndukController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleObscurePassword() {
    isObscurePassword.value = !isObscurePassword.value;
    debugPrint('Obscure password: ${isObscurePassword.value}');
  }

  void toggleObscurePasswordConf() {
    isObscurePasswordConf.value = !isObscurePasswordConf.value;
    debugPrint('Obscure passwordConf: ${isObscurePasswordConf.value}');
  }

  Future<void> registerWithEmail() async {
    try {
      state = ResultState.loading;

      final checkConnection = await ConnectivityHelper.checkConnection();

      if (checkConnection != ConnectivityResult.none) {
        final url = Uri.parse(URLs.baseUrl + URLs.register);

        final body = {
          'fullname': nameController.text,
          'nis': nomorIndukController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'passwordConfirmation': confirmPasswordController.text
        };

        debugPrint('Register url: $url');

        final response = await http.post(url, body: body);
        final jsonResponse = jsonDecode(response.body);

        debugPrint('Response from register: $jsonResponse');

        if (response.statusCode == 200) {
          state = ResultState.hasData;
          Get.snackbar('Success', jsonResponse['message']);
          Get.offNamed(Routes.HOME);
        } else if (response.statusCode == 400) {
          state = ResultState.error;
          Get.snackbar('Error', jsonResponse['message']);
        }
      }
    } catch (e) {
      state = ResultState.error;
      Get.snackbar('Error', e.toString());
    }
  }
}
