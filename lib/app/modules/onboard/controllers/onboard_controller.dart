import 'package:get/get.dart';

class OnboardController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
}
