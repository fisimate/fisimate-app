import 'package:fisimate/app/helpers/secure_storage_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onReady() {
    // getUserDataFromStorage('user').then((value) {
    //   if (value != null) {
    //     final userJson = jsonDecode(value);
    //     user.value = User.fromJson(userJson);
    //   }
    // });
    super.onReady();
  }

  Future<String?> getUserDataFromStorage(String key) async {
    final data = await SecureStorageHelper().readData(key: key);
    return data;
  }
}
