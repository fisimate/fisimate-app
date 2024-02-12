import 'package:fisimate/app/config/services/api_services.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/models/formula_bank.dart';
import 'package:get/get.dart';

class BankRumusController extends GetxController {
  Rx<ResultState> state = ResultState.initial.obs;
  RxString accessToken = ''.obs;
  List<FormulaBank>? formulaBankList;

  @override
  void onReady() async {
    accessToken.value = await StorageService.getAccessToken();
    getAllFormulaBank();
    super.onReady();
  }

  Future<void> getAllFormulaBank() async {
    state.value = ResultState.loading;
    try {
      // final connectivityResult = await ConnectivityHelper.checkConnection();
      formulaBankList =
          await ApiService.getFormulaBanks(accessToken: accessToken.value);
      state.value = ResultState.hasData;
      update(['bank_rumus']);
    } catch (e) {
      state.value = ResultState.error;
      throw Exception("bank formula error: $e");
    }
  }
}
