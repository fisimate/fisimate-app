import 'package:fisimate/app/modules/game/controllers/game_controller.dart';
import 'package:get/get.dart';

import '../controllers/simulation_content_controller.dart';

class SimulationContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SimulationContentController>(
      () => SimulationContentController(),
    );
    Get.lazyPut<GameController>(
      () => GameController(),
    );
  }
}
