import 'package:get/get.dart';

import '../controllers/bank_materi_controller.dart';

class BankMateriBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankMateriController>(
      () => BankMateriController(),
    );
  }
}
