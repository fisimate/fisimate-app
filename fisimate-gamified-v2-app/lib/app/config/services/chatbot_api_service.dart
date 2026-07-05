import 'package:dio/dio.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/models/generated_physics_exam.dart';
import 'package:logger/logger.dart';

class ChatbotApiService {
  static final ChatbotApiService _instance = ChatbotApiService._internal();
  Dio dio = Dio();
  Logger logger = Logger();

  factory ChatbotApiService() {
    return _instance;
  }

  ChatbotApiService._internal();

  Future<GeneratedPhycsicsExam> generateQuestion({
    required String chapter,
    required String accessToken,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.post(
        '${URLs.baseUrl}${URLs.chatbotGenerate}',
        data: {'chapter': chapter},
      );

      return GeneratedPhycsicsExam.fromJson(response.data['data']);
    } catch (e) {
      if (e is DioException) {
        logger.e(e.response?.data);
      } else {
        logger.e(e);
      }
      rethrow;
    }
  }
}
