import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fisimate/app/config/services/api_services.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/helpers/connectivity_helper.dart';
import 'package:fisimate/app/models/material_bank.dart';
import 'package:get/get.dart';

class BankMateriController extends GetxController {
  Rx<ResultState> state = ResultState.initial.obs;
  RxString accessToken = ''.obs;
  List<MaterialBank>? materialBankList;

  @override
  void onReady() async {
    accessToken.value = await StorageService.getAccessToken();
    getAllMaterialBank();

    super.onReady();
  }

  Future<void> getAllMaterialBank() async {
    try {
      state.value = ResultState.loading;

      final connectivityResult = await ConnectivityHelper.checkConnection();
      if (connectivityResult != ConnectivityResult.none) {
        log('Mulai');
        materialBankList =
            await ApiService.getMaterialBanks(accessToken: accessToken.value);
        state.value = ResultState.hasData;
        log('Successfully fetched all material bank');
        log('Access token value: ${accessToken.value}');
        update(['bank_materi']);
      }
    } catch (e) {
      throw Exception('Error on Get All Material Bank: $e');
    }
  }
}
