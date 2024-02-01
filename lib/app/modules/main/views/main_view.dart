import 'package:fisimate/app/modules/main/views/widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.pages[controller.currentIndex.value],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
