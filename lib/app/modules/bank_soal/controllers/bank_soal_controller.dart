import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/helpers/secure_storage_helper.dart';
import 'package:fisimate/app/models/exam_bank.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class BankSoalController extends GetxController {
  Rx<ResultState> state = ResultState.initial.obs;
  RxString accessToken = ''.obs;
  ExamBankModel? examBank;

  @override
  void onReady() async {
    await getAccessTokenFromStorage();
    getAllExamBank();
    super.onReady();
  }

  Future<void> getAllExamBank() async {
    try {
      state.value = ResultState.loading;
      final http.Response response = await http.get(
          Uri.parse(
            URLs.baseUrl + URLs.examBank,
          ),
          headers: {
            'Authorization' : 'Bearer ${accessToken.value}',
          });
      log("Response: ${response.body}");
      examBank = examBankModelFromJson(response.body);
      state.value = ResultState.hasData;
      update(['bank_soal']);
      log("Data fetched successfully");
    } catch (e) {
      log(
        e.toString(),
      );
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
