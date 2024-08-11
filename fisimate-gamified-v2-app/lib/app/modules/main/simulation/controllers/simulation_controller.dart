import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fisimate/app/config/services/simulation_api_service.dart';
import 'package:fisimate/app/data/responses/simulation/simulation/get_all_simulation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../config/services/storage_service.dart';
import '../../../../config/state/result_state.dart';

// Dev Dependencies
import 'package:logger/logger.dart';

class SimulationController extends GetxController {
  final RxList<SimulationDTO> _simulations = <SimulationDTO>[].obs;
  RxList<SimulationDTO> get simulations => _simulations;

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  final RxList<SimulationDTO> _filteredSimulations = <SimulationDTO>[].obs;
  RxList<SimulationDTO> get filteredSimulations => _filteredSimulations;

  final Rx<ResultState> _state = ResultState.initial.obs;
  ResultState get state => _state.value;

  final Logger _logger = Logger();
  Logger get logger => _logger;

  FocusNode searchFocusNode = FocusNode();

  void unfocusSearch() {
    searchFocusNode.unfocus();
  }

  @override
  void onClose() {
    _searchController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    _simulations.clear();
    _filteredSimulations.clear();
    getAllSimulations();
    super.onReady();
  }

  Future<void> getAllSimulations() async {
    final SimulationApiService _simulationApiService = SimulationApiService();
    try {
      _state.value = ResultState.loading;
      update();

      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult != ConnectivityResult.none) {
        final response = await _simulationApiService.getAllSimulations(
          accessToken: await StorageService.getAccessToken(),
        );

        if (response is List<SimulationDTO>) {
          _simulations.value = response;
          logger.i('Simulations: ${_simulations.length}');
          _filteredSimulations.value = response;
          _state.value = ResultState.hasData;
          update();
        } else {
          _state.value = ResultState.error;
          update();
          _logger.e('Error on Get All Simulations: $response');
        }
      }
    } catch (e) {
      _state.value = ResultState.error;
      update();
      _logger.e('Error on Get All Simulations: $e');
    }
  }

  void filterSimulations(String query) {
    _searchController.text = query;
    _logger.i('Filtering simulations : $query');
    if (query.isNotEmpty) {
      final List<SimulationDTO> searchedSimulations = _simulations
          .where((simulation) =>
              simulation.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _filteredSimulations.value = searchedSimulations;
      _logger.i('Filtered simulations : ${_filteredSimulations.length}');
    } else {
      _filteredSimulations.value = _simulations;
    }
    update();
  }

  void clearSearch() {
    _searchController.clear();
    _filteredSimulations.value = _simulations;
    update();
  }
}
