import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/helpers/connectivity_helper.dart';
import 'package:fisimate/app/helpers/secure_storage_helper.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:fisimate/app/widgets/custom_loading_dialog.dart';
import 'package:fisimate/app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isObscurePassword = true.obs;

  ResultState state = ResultState.initial;

  @override
  void onReady() {
    getEmailFromStorage('email').then((value) {
      if (value != null) {
        emailController.text = value;
      } else {
        final emailFromRegister = Get.arguments;
        if (emailFromRegister != null) {
          emailController.text = emailFromRegister as String;
        }
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void toggleObscurePassword() {
    isObscurePassword.value = !isObscurePassword.value;
    debugPrint('Obscure password: ${isObscurePassword.value}');
  }

  Future<void> loginWithEmail() async {
    try {
      state = ResultState.loading;
      showLoadingDialog();

      debugPrint('State: $state');

      final checkConnection = await ConnectivityHelper.checkConnection();

      if (checkConnection != ConnectivityResult.none) {
        final url = Uri.parse(URLs.baseUrl + URLs.login);

        final body = {
          'email': emailController.text,
          'password': passwordController.text,
        };

        debugPrint('Login url: $url');

        final response = await http.post(url, body: body);
        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200) {
          state = ResultState.hasData;
          final accessToken = jsonResponse['data']['access_token'];
          final refreshToken = jsonResponse['data']['refresh_token'];
          final user = jsonResponse['data']['user'];

          debugPrint('Access token: $accessToken');
          debugPrint('Refresh token: $refreshToken');

          SecureStorageHelper()
              .writeData(key: 'access_token', value: accessToken);
          SecureStorageHelper()
              .writeData(key: 'refresh_token', value: refreshToken);
          SecureStorageHelper().writeData(key: 'user', value: jsonEncode(user));
          SecureStorageHelper()
              .writeData(key: 'email', value: emailController.text);

          Get.offAllNamed(Routes.MAIN);
        } else {
          state = ResultState.error;
          Get.back();

          showErrorSnackbar(
              title: 'Terjadi Kesalahan', message: jsonResponse['message']);
        }
      } else {
        // TODO: Add else
        Get.back();
      }
    } catch (e) {
      state = ResultState.error;
      Get.back();
      showErrorSnackbar(title: 'Terjadi Kesalahan', message: e.toString());
      debugPrint('Catch error on Login with email: $e');
    } finally {
      state = ResultState.initial;
    }
  }

  Future<String?> getEmailFromStorage(String key) async {
    final data = await SecureStorageHelper().readData(key: key);
    return data;
  }
}
