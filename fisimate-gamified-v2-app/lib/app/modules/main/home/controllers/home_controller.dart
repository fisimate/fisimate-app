import 'package:fisimate/app/config/services/dashboard_api_service.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/config/services/user_api_service.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/data/responses/dashboard/get_available_chapter.dart';
import 'package:fisimate/app/data/responses/profile/get_user_profile.dart';
import 'package:fisimate/app/helpers/secure_storage_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final Rx<ResultState> _state = ResultState.initial.obs;
  ResultState get state => _state.value;

  final RxString _userFirstName = ''.obs;
  String get userFirstName => _userFirstName.value;

  final RxString _userProfilePhotoUrl = ''.obs;
  String get userProfilePhotoUrl => _userProfilePhotoUrl.value;

  final RxList<ChapterData> _availableChapters = <ChapterData>[].obs;
  List<ChapterData> get availableChapters => _availableChapters;

  @override
  void onReady() async {
    await getAvailableChapters();
    await getUserProfile();
    super.onReady();
  }

  Future<void> getUserProfile() async {
    final UserApiService userApiService = UserApiService();
    try {
      final response = await userApiService.getAllFormulaBank(
        accessToken: await StorageService.getAccessToken() ?? '',
      );

      if (response is UserProfileDTO) {
        _userFirstName.value = response.fullname.split(' ').first;
        _userProfilePhotoUrl.value = response.profilePicture ?? '';
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> getUserDataFromStorage(String key) async {
    final data = await SecureStorageHelper().readData(key: key);
    return data;
  }

  Future<void> getAvailableChapters() async {
    final DashboardApiService dashboardApiService = DashboardApiService();

    try {
      _state.value = ResultState.loading;
      final availableChaptersResponse = await dashboardApiService.getChapterDashboard(
        accessToken: await StorageService.getAccessToken() ?? '',
      );

      if (availableChaptersResponse is AvailableChapter) {
        _availableChapters.assignAll(availableChaptersResponse.data);

        _state.value = ResultState.hasData;
      }
    } on Exception catch (e) {
      _state.value = ResultState.error;
      print(e);
    }
  }
}
