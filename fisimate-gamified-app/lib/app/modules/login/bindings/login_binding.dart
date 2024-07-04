import 'package:get/get.dart';

import 'package:fisimate_flutter_app/app/modules/login/controllers/login_with_google_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginWithGoogleController>(
      () => LoginWithGoogleController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
