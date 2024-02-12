import 'package:fisimate/app/models/exam_bank.dart';
import 'package:get/get.dart';

class ModuleViewerController extends GetxController {
  ExamBank? examBank;
  
  @override
  void onInit() {
    examBank = Get.arguments;
    super.onInit();
  }
}
