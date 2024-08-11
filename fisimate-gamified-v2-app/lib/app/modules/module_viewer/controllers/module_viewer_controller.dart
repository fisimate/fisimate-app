import 'package:fisimate/app/data/responses/exam_bank/get_all_exam_bank_response.dart';
import 'package:fisimate/app/data/responses/formula_bank/get_all_formula_bank.dart';
import 'package:fisimate/app/models/material_bank.dart';
import 'package:get/get.dart';

class ModuleViewerController extends GetxController {
  RxString argumentType = ''.obs;

  ExamBankSubChapter? examBankElement;
  MaterialBankElement? materialBankElement;
  FormulaBankSubChapter? formulaBankElement;
  String? quizFilePath;

  @override
  void onInit() {
    final arguments = Get.arguments as Map<String, dynamic>;
    switch (arguments['type']) {
      case 'exam_bank':
        examBankElement = arguments['data'] as ExamBankSubChapter;
        argumentType.value = 'exam_bank';
        break;
      case 'material_bank':
        materialBankElement = arguments['data'] as MaterialBankElement;
        argumentType.value = 'material_bank';
        break;
      case 'formula_bank':
        formulaBankElement = arguments['data'] as FormulaBankSubChapter;
        argumentType.value = 'formula_bank';
        break;
      case 'quiz_review':
        quizFilePath = arguments['data'] as String;
        argumentType.value = 'quiz_review';
        break;
      default:
    }
    super.onInit();
  }
}
