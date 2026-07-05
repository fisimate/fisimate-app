import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fisimate/app/config/services/exam_bank_api_service.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/data/responses/exam_bank/get_all_exam_bank_response.dart';
import 'package:fisimate/app/helpers/connectivity_helper.dart';
import 'package:get/get.dart';

class BankSoalController extends GetxController {
  Rx<ResultState> state = ResultState.initial.obs;
  RxString accessToken = ''.obs;

  RxList<ExamBankChapter> chapterList = <ExamBankChapter>[].obs;
  RxInt chapterCount = 0.obs;
  RxInt subChapterCount = 0.obs;

  @override
  void onReady() async {
    accessToken.value = await StorageService.getAccessToken() ?? '';
    getAllExamBank();
    super.onReady();
  }

  Future<void> getAllExamBank() async {
    final ExamBankApiService examBankApiService = ExamBankApiService();
    state.value = ResultState.loading;
    try {
      final connectivityResult = await ConnectivityHelper.checkConnection();
      if (connectivityResult != ConnectivityResult.none) {
        final response = await examBankApiService.getAllExamBank(
          accessToken: accessToken.value,
        );

        if (response is GetAllExamBankResponse) {
          chapterList.assignAll(response.data.examBankChapters);
          chapterCount.value = response.data.count.chapters;
          subChapterCount.value = response.data.count.subChapters;
          state.value = ResultState.hasData;
        } else {
          state.value = ResultState.error;
        }
      }
      update();
    } catch (e) {
      state.value = ResultState.error;
      throw Exception("Get All Exam Bank Exception : $e");
    }
  }
}
