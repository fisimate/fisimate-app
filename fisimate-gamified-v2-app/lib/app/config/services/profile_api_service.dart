import 'package:dio/dio.dart';
import 'package:fisimate/app/config/api/urls.dart';
import 'package:fisimate/app/data/responses/profile/update_user_password_request.dart';
import 'package:fisimate/app/data/responses/profile/update_user_password_response.dart';
import 'package:fisimate/app/data/responses/profile/update_user_profile.dart';
import 'package:logger/logger.dart';

class ProfileApiService {
  static final ProfileApiService _instance = ProfileApiService._internal();
  Dio dio = Dio();
  Logger logger = Logger();

  factory ProfileApiService() {
    return _instance;
  }

  ProfileApiService._internal();

  Future<dynamic> updateUserProfile({
    required String accessToken,
    required String fullname,
    required String email,
    required String nis,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.put(
        '${URLs.baseUrl}${URLs.updateUserProfile}',
        data: {
          "fullname": fullname,
          "email": email,
          "nis": nis,
        },
      );
      logger.i(response.data);
      return UpdateUserProfileResponse.fromJson(
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

  Future<dynamic> updateUserPassword({
    required String accessToken,
    required String oldPassword,
    required String newPassword,
    required String passwordConfirmation,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final Response response = await dio.post(
        '${URLs.baseUrl}users/password/update',
        data: UpdateUserPasswordRequest(
          oldPassword: oldPassword,
          newPassword: newPassword,
          passwordConfirmation: passwordConfirmation,
        ).toJson(),
      );

      logger.i(response.data);

      return UpdateUserPasswordResponse.fromJson(
        response.data,
      );
    } catch (e) {
      if (e is DioException) {
        logger.e(e.response!.data);
      } else {
        logger.e(e);
      }
      return e.toString();
    }
  }
}
