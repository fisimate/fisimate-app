import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fisimate_flutter_app/app/config/services/api_services.dart';
import 'package:fisimate_flutter_app/app/config/services/storage_service.dart';
import 'package:fisimate_flutter_app/app/config/state/result_state.dart';
import 'package:fisimate_flutter_app/app/helpers/connectivity_helper.dart';
import 'package:fisimate_flutter_app/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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

      final connectivityResult = await ConnectivityHelper.checkConnection();

      if (connectivityResult != ConnectivityResult.none) {
        final response = await ApiService.register(
          fullname: nameController.text,
          nis: nomorIndukController.text,
          email: emailController.text,
          password: passwordController.text,
          passwordConfirmation: confirmPasswordController.text,
        );
        final jsonResponse = jsonDecode(response.body);

        debugPrint('Response from register: $jsonResponse');

        if (response.statusCode == 200) {
          state = ResultState.hasData;
          Get.snackbar('Register Berhasil!', jsonResponse['message']);
          StorageService.saveRegisteredStatus(status: true);
          Get.offNamed(Routes.LOGIN, arguments: emailController.text);
        } else if (response.statusCode == 400) {
          state = ResultState.error;
          Get.snackbar('Terjadi Kesalahan', jsonResponse['message']);
        }
      }
    } catch (e) {
      state = ResultState.error;
      Get.snackbar('Error', e.toString());
      throw Exception(e.toString());
    }
  }
}
