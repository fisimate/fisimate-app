import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/config/services/api_services.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/helpers/connectivity_helper.dart';
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
    StorageService.getEmail().then((value) {
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

      final connectivityResult = await ConnectivityHelper.checkConnection();

      if (connectivityResult != ConnectivityResult.none) {
        final response = await ApiService.login(
            email: emailController.text, password: passwordController.text);
        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200) {
          state = ResultState.hasData;
          final accessToken = jsonResponse['data']['access_token'];
          final refreshToken = jsonResponse['data']['refresh_token'];
          final user = jsonResponse['data']['user'];

          debugPrint('Access token: $accessToken');
          debugPrint('Refresh token: $refreshToken');

          StorageService.saveAccessToken(accessToken: accessToken);
          StorageService.saveRefreshToken(refreshToken: refreshToken);
          StorageService.saveUser(user: jsonEncode(user));
          StorageService.saveEmail(email: emailController.text);
          StorageService.saveLoggedInStatus(status: true);

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
      throw Exception(e.toString());
    } finally {
      state = ResultState.initial;
    }
  }

  Future loginWithGoogle() async {
    try {
      showLoadingDialog();
      final connectivityResult = await ConnectivityHelper.checkConnection();

      if (connectivityResult != ConnectivityResult.none) {
        final url = Uri.parse(URLs.baseUrl + URLs.loginWithGoogle);

        final response = await http.get(url);
        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200) {
          final googleAuthUrl = jsonResponse['data']['authUrl'];

          debugPrint('Google auth url: $googleAuthUrl');

          Get.toNamed(Routes.GOOGLE_LOGIN, arguments: googleAuthUrl);
        } else {
          Get.back();
          showErrorSnackbar(
              title: 'Terjadi Kesalahan', message: jsonResponse['message']);
        }
      }
    } catch (e) {
      Get.back();
      showErrorSnackbar(title: 'Terjadi Kesalahan', message: e.toString());
      debugPrint('Catch error on Login with Google: $e');
    }
  }
}
