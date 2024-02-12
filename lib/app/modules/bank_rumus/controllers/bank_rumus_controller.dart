import 'dart:developer';

import 'package:fisimate/app/config/services/api_services.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/helpers/secure_storage_helper.dart';
import 'package:fisimate/app/models/formula_bank.dart';
import 'package:get/get.dart';

class BankRumusController extends GetxController {
  Rx<ResultState> state = ResultState.initial.obs;
  RxString accessToken = ''.obs;
  List<FormulaBank>? formulaBankList;

  @override
  void onReady() async {
    await getAccessTokenFromStorage();
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

  Future<void> getAccessTokenFromStorage() async {
    final String? fetchedAccessToken =
        await SecureStorageHelper().readData(key: 'access_token');
    log(fetchedAccessToken.toString());
    if (fetchedAccessToken != null) {
      accessToken.value = fetchedAccessToken;
    }
  }
}
