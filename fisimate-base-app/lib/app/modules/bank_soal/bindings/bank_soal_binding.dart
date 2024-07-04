import 'package:get/get.dart';

import '../controllers/bank_soal_controller.dart';

class BankSoalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankSoalController>(
      () => BankSoalController(),
    );
  }
}
