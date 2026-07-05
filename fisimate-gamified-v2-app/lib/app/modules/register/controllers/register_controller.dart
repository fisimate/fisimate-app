import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fisimate/app/config/services/api_services.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/helpers/connectivity_helper.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:fisimate/app/widgets/custom_snackbar.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  FocusNode nameFocus = FocusNode();

  TextEditingController nomorIndukController = TextEditingController();
  FocusNode nomorIndukFocus = FocusNode();

  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();

  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode confirmPasswordFocus = FocusNode();

  RxBool isObscurePassword = true.obs;
  RxBool isObscurePasswordConf = true.obs;

  ResultState state = ResultState.initial;

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

  void unfocusAll() {
    nameFocus.unfocus();
    nomorIndukFocus.unfocus();
    emailFocus.unfocus();
    passwordFocus.unfocus();
    confirmPasswordFocus.unfocus();
  }

  Future<void> registerWithEmail() async {
    try {
      state = ResultState.loading;
      update();

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
          showSuccessSnackbar(
            title: 'Daftar Berhasil',
            message: jsonResponse['message'],
          );
          StorageService.saveRegisteredStatus(status: true);
          Get.offNamed(Routes.LOGIN, arguments: emailController.text);
        } else if (response.statusCode == 400) {
          state = ResultState.error;
          showErrorSnackbar(
            title: 'Gagal',
            message: jsonResponse['message'].toString().replaceFirst(
              jsonResponse['message'][0],
              jsonResponse['message'][0].toString().toUpperCase(),
            ),
          );
        }
        update();
      }
    } catch (e) {
      state = ResultState.error;
      update();
      showErrorSnackbar(
        title: 'Gagal',
        message: e.toString(),
      );
      throw Exception(
        e.toString(),
      );
    }
  }
}
