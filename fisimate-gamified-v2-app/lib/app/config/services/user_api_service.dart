import 'package:dio/dio.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/data/responses/profile/get_user_profile.dart';
import 'package:logger/logger.dart';

class UserApiService {
  static final UserApiService _instance = UserApiService._internal();
  Dio dio = Dio();
  Logger logger = Logger();

  factory UserApiService() {
    return _instance;
  }

  UserApiService._internal();

  Future<dynamic> getAllFormulaBank({
    required String accessToken,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.get(
        '${URLs.baseUrl}/users/profile',
      );

      logger.i(response.data);

      final UserProfileDTO getUserProfileResponse =
          UserProfileDTO.fromJson(response.data['data']);

      return getUserProfileResponse;
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
