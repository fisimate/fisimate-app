import 'package:get/get.dart';

import '../controllers/simulation_result_controller.dart';

class SimulationResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SimulationResultController>(
      () => SimulationResultController(),
    );
  }
}
