import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fisimate/app/config/services/formula_bank_api_service.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/data/responses/formula_bank/get_all_formula_bank.dart';
import 'package:fisimate/app/helpers/connectivity_helper.dart';
import 'package:get/get.dart';

class BankRumusController extends GetxController {
  Rx<ResultState> state = ResultState.initial.obs;
  RxString accessToken = ''.obs;

  RxList<FormulaBankChapter> chapterList = <FormulaBankChapter>[].obs;
  RxInt chapterCount = 0.obs;
  RxInt subChapterCount = 0.obs;

  @override
  void onReady() async {
    accessToken.value = await StorageService.getAccessToken();
    getAllFormulaBank();
    super.onReady();
  }

  Future<void> getAllFormulaBank() async {
    final FormulaBankApiService formulaBankApiService = FormulaBankApiService();
    state.value = ResultState.loading;
    try {
      final connectivityResult = await ConnectivityHelper.checkConnection();
      if (connectivityResult != ConnectivityResult.none) {
        final response = await formulaBankApiService.getAllFormulaBank(
          accessToken: accessToken.value,
        );

        if (response is GetAllFormulaBankResponse) {
          chapterList.assignAll(response.data.formulaBankChapters);
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
      throw Exception("Get All Formula Bank Exception : $e");
    }
  }
}
