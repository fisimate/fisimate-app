import 'package:get/get.dart';

class OnboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardBinding>(
      () => OnboardBinding(),
    );
  }
}
