import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Rxn<AnimationController> _animationController =
      Rxn<AnimationController>();
  AnimationController? get animationController => _animationController.value;

  final Rxn<Animation<double>> _radiusAnimation = Rxn<Animation<double>>();
  Animation<double>? get radiusAnimation => _radiusAnimation.value;

  final Rxn<Animation<double>> _sizeAnimation = Rxn<Animation<double>>();
  Animation<double>? get sizeAnimation => _sizeAnimation.value;

  @override
  void onInit() {
    super.onInit();
    log("oninit");
    _animationController.value = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );
    _radiusAnimation.value = Tween(begin: 0.0, end: 450.0)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(_animationController.value!)
      ..addListener(() {
        update();
      });

    _sizeAnimation.value = Tween(begin: Get.height, end: 200.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_animationController.value!)
      ..addListener(() {
        update();
      });
    _animationController.value?.forward();

    _animationController.value?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offNamed('/onboard');
      }
    });
  }

  @override
  void onClose() {
    log("oonClonse");
    _animationController.value?.dispose();
    super.onClose();
  }
}
