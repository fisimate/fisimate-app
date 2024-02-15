import 'package:get/get.dart';

import '../controllers/bank_rumus_controller.dart';

class BankRumusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankRumusController>(
      () => BankRumusController(),
    );
  }
}
