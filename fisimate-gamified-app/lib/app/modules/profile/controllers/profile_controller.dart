import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fisimate_flutter_app/app/config/services/api_services.dart';
import 'package:fisimate_flutter_app/app/config/services/storage_service.dart';
import 'package:fisimate_flutter_app/app/config/state/result_state.dart';
import 'package:fisimate_flutter_app/app/helpers/connectivity_helper.dart';
import 'package:fisimate_flutter_app/app/models/user_profile.dart';
import 'package:fisimate_flutter_app/app/routes/app_pages.dart';
import 'package:fisimate_flutter_app/app/widgets/custom_loading_dialog.dart';
import 'package:fisimate_flutter_app/app/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

// Dev Dependencies
import 'package:logger/logger.dart';

class ProfileController extends GetxController {
  final Rx<ResultState> _state = ResultState.initial.obs;
  ResultState get state => _state.value;

  final Rx<UserProfile> _userProfile = UserProfile().obs;
  UserProfile get userProfile => _userProfile.value;

  final Logger _logger = Logger();
  Logger get logger => _logger;

  @override
  void onReady() async {
    getUserProfile();
    super.onReady();
  }

  Future<void> getUserProfile() async {
    final accessToken = await StorageService.getAccessToken();
    final refreshToken = await StorageService.getRefreshToken();
    try {
      _state.value = ResultState.loading;

      final connectivityResult = await ConnectivityHelper.checkConnection();
      if (connectivityResult != ConnectivityResult.none) {
        _userProfile.value = await ApiService.getUserProfile(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

        // Log the value
        logger.i(_userProfile.value.toJson());

        _state.value = ResultState.hasData;

        update(["profile_photo"]);
      }
    } catch (e) {
      throw Exception('Error on Get User Profile: $e');
    }
  }

  logout() async {
    final connectivityResult = await ConnectivityHelper.checkConnection();

    if (connectivityResult != ConnectivityResult.none) {
      try {
        showLoadingDialog();
        await StorageService.removeAllExceptEmailAndRegisteredStatus();
        Get.offAllNamed(Routes.LOGIN);
      } catch (e) {
        showErrorSnackbar(
          title: 'Logout Gagal',
          message: 'Terjadi kesalahan saat logout, silahkan coba lagi!',
        );
      }
    }
  }
}
