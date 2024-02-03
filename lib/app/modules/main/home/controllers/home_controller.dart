import 'dart:convert';

import 'package:fisimate/app/helpers/secure_storage_helper.dart';
import 'package:fisimate/app/models/user.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final user = User().obs;
  final userFirstName = ''.obs;

  @override
  void onReady() {
    getUserDataFromStorage('user').then((value) {
      if (value != null) {
        final userJson = jsonDecode(value);
        user.value = User.fromJson(userJson);
        userFirstName.value = user.value.fullname!.split(' ')[0];
      }
    });
    super.onReady();
  }

  Future<String?> getUserDataFromStorage(String key) async {
    final data = await SecureStorageHelper().readData(key: key);
    return data;
  }
}
