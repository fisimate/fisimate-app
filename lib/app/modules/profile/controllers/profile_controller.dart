import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fisimate/app/config/services/api_services.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/helpers/connectivity_helper.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:fisimate/app/widgets/custom_loading_dialog.dart';
import 'package:fisimate/app/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  logout() async {
    final connectivityResult = await ConnectivityHelper.checkConnection();

    if (connectivityResult != ConnectivityResult.none) {
      try {
        showLoadingDialog();
        final accessToken = await StorageService.getAccessToken();
        final refreshToken = await StorageService.getRefreshToken();
        final response = await ApiService.logout(
            accessToken: accessToken, refreshToken: refreshToken);

        if (response.statusCode == 200) {
          await StorageService.removeAllExceptEmailAndRegisteredStatus();
          Get.offAllNamed(Routes.LOGIN);
        } else if (response.statusCode == 401) {
          Get.back();
          final jsonResponse = jsonDecode(response.body);

          showErrorSnackbar(
              title: 'Logout Gagal', message: jsonResponse['message']);
        }
      } catch (e) {
        throw Exception('Error on logout $e');
      }
    }
  }
}
