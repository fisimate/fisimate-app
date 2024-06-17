import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../config/services/api_services.dart';
import '../../../../config/services/storage_service.dart';
import '../../../../config/state/result_state.dart';
import '../../../../helpers/connectivity_helper.dart';
import '../../../../models/simulation.dart' as simulation_model;

// Dev Dependencies
import 'package:logger/logger.dart';

class SimulationController extends GetxController {
  final RxList<simulation_model.Simulation> _simulations = <simulation_model.Simulation>[].obs;
  RxList<simulation_model.Simulation> get simulations => _simulations;

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  final RxList<simulation_model.Simulation> _filteredSimulations = <simulation_model.Simulation>[].obs;
  RxList<simulation_model.Simulation> get filteredSimulations => _filteredSimulations;

  final Rx<ResultState> _state = ResultState.initial.obs;
  ResultState get state => _state.value;

  final Logger _logger = Logger();
  Logger get logger => _logger;

  @override
  void onReady() {
    getSimulations();
    super.onReady();
  }

  Future<void> getSimulations() async {
    final accessToken = await StorageService.getAccessToken();
    final refreshToken = await StorageService.getRefreshToken();
    try {
      _state.value = ResultState.loading;

      final connectivityResult = await ConnectivityHelper.checkConnection();
      if (connectivityResult != ConnectivityResult.none) {
        _simulations.value = await ApiService.getSimulations(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

        // Log the value
        logger.i(_simulations.toJson());

        _state.value = ResultState.hasData;

        update();
      }
    } catch (e) {
      throw Exception('Error on Get Simulations: $e');
    }
  }

  void filterSimulations(String query) {
    _logger.i('Filtering simulations : $query');
    if (query.isNotEmpty) {
      final List<simulation_model.Simulation> searchedSimulations = _simulations
          .where((simulation) =>
              simulation.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _filteredSimulations.value = searchedSimulations;
      _logger.i('Filtered simulations : ${_filteredSimulations.length}');
    } else {
      _filteredSimulations.value = _simulations;
    }
    update();
  }
}
