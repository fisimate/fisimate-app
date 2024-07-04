import 'package:fisimate_flutter_app/app/config/services/storage_service.dart';
import 'package:fisimate_flutter_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;

  navigate() async {
    final registeredStatus = await StorageService.getRegisteredStatus();

    if (registeredStatus) {
      Get.offNamed(Routes.LOGIN);
    } else {
      Get.offNamed(Routes.REGISTER);
    }
  }
}
