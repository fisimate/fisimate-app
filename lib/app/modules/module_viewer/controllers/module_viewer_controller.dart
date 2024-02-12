import 'package:fisimate/app/models/exam_bank.dart';
import 'package:fisimate/app/models/formula_bank.dart';
import 'package:fisimate/app/models/material_bank.dart';
import 'package:get/get.dart';

class ModuleViewerController extends GetxController {
  RxString argumentType = ''.obs;
  ExamBankElement? examBankElement;
  MaterialBankElement? materialBankElement;
  FormulaBankElement? formulaBankElement;

  @override
  void onInit() {
    final arguments = Get.arguments as Map<String, dynamic>;
    switch (arguments['type']) {
      case 'exam_bank':
        examBankElement = arguments['data'] as ExamBankElement;
        argumentType.value = 'exam_bank';
        break;
      case 'material_bank':
        materialBankElement = arguments['data'] as MaterialBankElement;
        argumentType.value = 'material_bank';
        break;
      case 'formula_bank':
        formulaBankElement = arguments['data'] as FormulaBankElement;
        argumentType.value = 'formula_bank';
        break;
      default:
    }
    super.onInit();
  }
}
