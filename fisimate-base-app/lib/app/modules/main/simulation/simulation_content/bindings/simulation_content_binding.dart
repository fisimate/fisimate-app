import 'package:get/get.dart';

import '../controllers/simulation_content_controller.dart';

class SimulationContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SimulationContentController>(
      () => SimulationContentController(),
    );
  }
}
