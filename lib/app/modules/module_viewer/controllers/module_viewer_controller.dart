import 'package:fisimate/app/models/exam_bank.dart';
import 'package:fisimate/app/models/material_bank.dart';
import 'package:get/get.dart';

class ModuleViewerController extends GetxController {
  RxString argumentType = ''.obs;
  ExamBank? examBank;
  MaterialBankElement? materialBank;

  @override
  void onInit() {
    final arguments = Get.arguments as Map<String, dynamic>;
    switch (arguments['type']) {
      case 'exam_bank':
        examBank = arguments['data'] as ExamBank;
        argumentType.value = 'exam_bank';
        break;
      case 'material_bank':
        materialBank = arguments['data'] as MaterialBankElement;
        argumentType.value = 'material_bank';
        break;
      default:
    }
    super.onInit();
  }
}
