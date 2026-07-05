import 'package:dio/dio.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:logger/logger.dart';
import 'package:fisimate/app/data/responses/exam_bank/get_all_exam_bank_response.dart';

class ExamBankApiService {
  static final ExamBankApiService _instance = ExamBankApiService._internal();
  Dio dio = Dio();
  Logger logger = Logger();

  factory ExamBankApiService() {
    return _instance;
  }

  ExamBankApiService._internal();

  Future<dynamic> getAllExamBank({
    required String accessToken,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.get(
        '${URLs.baseUrl}exam-banks',
      );

      logger.i(response.data);

      final GetAllExamBankResponse getAllExamBankResponse = GetAllExamBankResponse.fromJson(response.data);

      return getAllExamBankResponse;
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
