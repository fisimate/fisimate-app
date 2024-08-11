import 'package:dio/dio.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/get_simulation_material_response.dart';
import 'package:fisimate/app/data/responses/simulation/simulation/get_all_simulation.dart';
import 'package:fisimate/app/data/responses/simulation/simulation/post_simulation_progress_request.dart';
import 'package:fisimate/app/data/responses/simulation/simulation/post_simulation_progress_response.dart';
import 'package:logger/logger.dart';

class SimulationApiService {
  static final SimulationApiService _instance =
      SimulationApiService._internal();
  Dio dio = Dio();
  Logger logger = Logger();

  factory SimulationApiService() {
    return _instance;
  }

  SimulationApiService._internal();

  Future<dynamic> getSimulationMaterialById({
    required String accessToken,
    required String simulationId,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.get(
        '${URLs.baseUrl}/simulations/$simulationId/materials',
      );

      logger.i(response.data);

      final GetSimulationMaterialResponse simulationMaterialResponse =
          GetSimulationMaterialResponse.fromJson(response.data);

      return simulationMaterialResponse;
    } catch (e) {
      if (e is DioException) {
        logger.e(e.response!.data);
      } else {
        logger.e(e);
      }
      return e;
    }
  }

  Future<dynamic> getAllSimulations({
    required String accessToken,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.get(
        '${URLs.baseUrl}/simulations',
      );

      logger.i(response.data);

      final List<SimulationDTO> allSimulationResponse =
          List<SimulationDTO>.from(
        response.data['data'].map(
          (x) => SimulationDTO.fromJson(x),
        ),
      );

      return allSimulationResponse;
    } catch (e) {
      if (e is DioException) {
        logger.e(e.response!.data);
      } else {
        logger.e(e);
      }
      return e;
    }
  }

  Future<dynamic> postSimulationProgressById({
    required String accessToken,
    required String simulationId,
    required int progress,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.post(
        '${URLs.baseUrl}/simulations/$simulationId/progress',
        data: PostSimulationProgressRequest(
          currentStep: progress,
        ).toJson(),
      );

      logger.i(response.data);

      final PostSimulationProgressResponse simulationProgressResponse =
          PostSimulationProgressResponse.fromJson(response.data);

      return simulationProgressResponse;
    } catch (e) {
      if (e is DioException) {
        logger.e(e.response!.data);
      } else {
        logger.e(e);
      }
      return e;
    }
  }
}
