import 'package:dio/dio.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/get_quiz_review_response.dart';
import 'package:logger/logger.dart';

class QuizApiService {
  static final QuizApiService _instance = QuizApiService._internal();
  Dio dio = Dio();
  Logger logger = Logger();

  factory QuizApiService() {
    return _instance;
  }

  QuizApiService._internal();

  Future<dynamic> getQuizReviewBySimulationId({
    required String accessToken,
    required String simulationId,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.get(
        '${URLs.baseUrl}/quizzes/$simulationId/review',
      );

      logger.i(response.data);

      final GetQuizReviewResponse getQuizReviewResponse =
          GetQuizReviewResponse.fromJson(response.data);

      return getQuizReviewResponse;
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
