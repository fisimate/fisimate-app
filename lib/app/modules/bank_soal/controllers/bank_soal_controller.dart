import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fisimate/app/config/services/api_services.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/helpers/connectivity_helper.dart';
import 'package:fisimate/app/models/exam_bank.dart';
import 'package:get/get.dart';
import 'dart:developer';

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
    try {
      state.value = ResultState.loading;

      final connectivityResult = await ConnectivityHelper.checkConnection();
      if (connectivityResult != ConnectivityResult.none) {
        log('Mulai');
        examBankList =
            await ApiService.getExamBanks(accessToken: accessToken.value);
        state.value = ResultState.hasData;
        log('Successfully fetched all exam bank');
        log('Access token value: ${accessToken.value}');
        update(['bank_soal']);
      }
    } catch (e) {
      throw Exception('Error on Get All Exam Bank: $e');
    }
  }
}
