import 'package:dio/dio.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/get_quiz_result_response.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/post_answer_request.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/post_answer_response.dart';
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
        '${URLs.baseUrl}simulations/$simulationId/quizzes',
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

  Future<dynamic> submitAnswers({
    required String accessToken,
    required String simulationId,
    required List<AnswerItem> answers,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final PostAnswerRequest postAnswerRequest = PostAnswerRequest(
        responses: answers,
      );

      logger.d(postAnswerRequest.toJson());

      final Response response = await dio.post(
        '${URLs.baseUrl}quizzes/$simulationId/attempt',
        data: postAnswerRequest.toJson(),
      );

      logger.i(response.data);

      final PostAnswerResponse postAnswerResponse = PostAnswerResponse.fromJson(response.data);

      return postAnswerResponse;
    } catch (e) {
      if (e is DioException) {
        logger.e(e.response!.data);
      } else {
        logger.e(e);
      }
      return e;
    }
  }

  Future<dynamic> getQuizResult({
    required String accessToken,
    required String simulationId,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.get(
        '${URLs.baseUrl}quizzes/result/$simulationId',
      );

      logger.i(response.data);

      final QuizResultResponse quizResultResponse = QuizResultResponse.fromJson(response.data);

      return quizResultResponse;
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
