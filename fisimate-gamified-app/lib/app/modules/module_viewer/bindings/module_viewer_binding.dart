import 'package:get/get.dart';

import '../controllers/module_viewer_controller.dart';

class ModuleViewerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModuleViewerController>(
      () => ModuleViewerController(),
    );
  }
}
