import 'package:dio/dio.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/data/responses/formula_bank/get_all_formula_bank.dart';
import 'package:logger/logger.dart';

class FormulaBankApiService {
  static final FormulaBankApiService _instance =
      FormulaBankApiService._internal();
  Dio dio = Dio();
  Logger logger = Logger();

  factory FormulaBankApiService() {
    return _instance;
  }

  FormulaBankApiService._internal();

  Future<dynamic> getAllFormulaBank({
    required String accessToken,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.get(
        '${URLs.baseUrl}/formula-banks',
      );

      logger.i(response.data);

      final GetAllFormulaBankResponse getAllFormulaBankResponse =
          GetAllFormulaBankResponse.fromJson(response.data);

      return getAllFormulaBankResponse;
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
