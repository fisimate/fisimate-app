import 'package:dio/dio.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/data/responses/dashboard/get_available_chapter.dart';
import 'package:fisimate/app/data/responses/dashboard/get_leaderboard.dart';
import 'package:logger/logger.dart';

class DashboardApiService {
  static final DashboardApiService _instance = DashboardApiService._internal();
  Dio dio = Dio();
  Logger logger = Logger();

  factory DashboardApiService() {
    return _instance;
  }

  DashboardApiService._internal();

  Future<dynamic> getChapterDashboard({
    required String accessToken,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.get(
        '${URLs.baseUrl}/chapters',
      );

      logger.i(response.data);

      final AvailableChapter leaderboardResponse =
          AvailableChapter.fromJson(response.data);

      return leaderboardResponse;
    } catch (e) {
      if (e is DioException) {
        logger.e(e.response!.data);
      } else {
        logger.e(e);
      }
      return e;
    }
  }

  Future<dynamic> getLeaderboard({
    required String accessToken,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.get(
        '${URLs.baseUrl}/dashboard/leaderboard',
      );

      logger.i(response.data);

      final Leaderboard leaderboardResponse =
          Leaderboard.fromJson(response.data);

      return leaderboardResponse;
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
