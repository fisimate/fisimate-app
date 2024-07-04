import 'package:fisimate_flutter_app/app/config/services/api_services.dart';
import 'package:fisimate_flutter_app/app/config/services/storage_service.dart';
import 'package:fisimate_flutter_app/app/config/state/result_state.dart';
import 'package:fisimate_flutter_app/app/models/exam_bank.dart';
import 'package:get/get.dart';

class BankSoalController extends GetxController {
  Rx<ResultState> state = ResultState.initial.obs;
  RxString accessToken = ''.obs;
  List<ExamBank>? examBankList;

  @override
  void onReady() async {
    accessToken.value = await StorageService.getAccessToken();
    getAllExamBank();
    super.onReady();
  }

  Future<void> getAllExamBank() async {
    state.value = ResultState.loading;
    try {
      // final connectivityResult = await ConnectivityHelper.checkConnection();
      examBankList =
          await ApiService.getExamBanks(accessToken: accessToken.value);
      state.value = ResultState.hasData;
      update(['bank_soal']);
    } catch (e) {
      state.value = ResultState.error;
      throw Exception("bank formula error: $e");
    }
  }
}
