import 'package:dio/dio.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:logger/logger.dart';

class ChapterApiService {
  static final ChapterApiService _instance = ChapterApiService._internal();
  Dio dio = Dio();
  Logger logger = Logger();

  factory ChapterApiService() {
    return _instance;
  }

  ChapterApiService._internal();

  Future<dynamic> getAllChaptersName({
    required String accessToken,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.get(
        '${URLs.baseUrl}chapters',
      );

      final List<String> chapterNames = [];

      for (var chapter in response.data['data']) {
        chapterNames.add(
          chapter['name'],
        );
      }

      return chapterNames;
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
