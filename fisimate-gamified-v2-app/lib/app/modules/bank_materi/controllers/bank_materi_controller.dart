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
  MaterialBank? materialBank;

  @override
  void onReady() async {
    getAllMaterialBank();

    super.onReady();
  }

  Future<void> getAllMaterialBank() async {
    final accessToken = await StorageService.getAccessToken() ?? '';
    final refreshToken = await StorageService.getRefreshToken() ?? '';
    try {
      state.value = ResultState.loading;

      final connectivityResult = await ConnectivityHelper.checkConnection();
      if (connectivityResult != ConnectivityResult.none) {
        log('Mulai');
        materialBank = await ApiService.getMaterialBanks(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
        state.value = ResultState.hasData;
        log('Successfully fetched all material bank');
        update(['bank_materi', 'bank_materi_counter']);
      }
    } catch (e) {
      throw Exception('Error on Get All Material Bank: $e');
    }
  }
}
