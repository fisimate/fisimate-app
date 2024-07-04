import 'package:dio/dio.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/question_response.dart';
import 'package:logger/logger.dart';

class QuestionApiService {
  static final QuestionApiService _instance = QuestionApiService._internal();
  Dio dio = Dio();
  Logger logger = Logger();
  
  factory QuestionApiService() {
    return _instance;
  }

  QuestionApiService._internal();

  Future<dynamic> getAllQuestionsById({
    required String accessToken,
    required String simulationId,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.get(
        '${URLs.baseUrl}/simulations/$simulationId/quizzes',
      );
      logger.i(response.data);
      return QuestionResponse.fromJson(
        response.data,
      );
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
