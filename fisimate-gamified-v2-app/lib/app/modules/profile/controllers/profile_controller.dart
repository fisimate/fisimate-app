import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fisimate/app/config/services/api_services.dart';
import 'package:fisimate/app/config/services/profile_api_service.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/helpers/connectivity_helper.dart';
import 'package:fisimate/app/models/user_profile.dart';
import 'package:fisimate/app/modules/main/home/controllers/home_controller.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/widgets/custom_loading_dialog.dart';
import 'package:fisimate/app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final Rx<ResultState> _state = ResultState.initial.obs;
  final Rx<ResultState> _state2 = ResultState.initial.obs;
  
  ResultState get state => _state.value;
  ResultState get imageState => _state2.value;

  final Rx<UserProfile> _userProfile = UserProfile().obs;
  UserProfile get userProfile => _userProfile.value;

  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _nisController = TextEditingController();
  TextEditingController get nisController => _nisController;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

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

        _nameController.text = _userProfile.value.fullname ?? '';
        _nisController.text = _userProfile.value.nis ?? '';
        _emailController.text = _userProfile.value.email ?? '';

        _state.value = ResultState.hasData;
      }
    } catch (e) {
      throw Exception('Error on Get User Profile: $e');
    }

    HomeController homeController = Get.find<HomeController>();
    homeController.getUserProfile();
  }

  Future<void> updateUserProfile() async {
    final profileApiService = ProfileApiService();
    final accessToken = await StorageService.getAccessToken();
    final fullname = _nameController.value.text;
    final email = _emailController.value.text;
    final nis = _nisController.value.text;

    final connectivityResult = await ConnectivityHelper.checkConnection();
    if (connectivityResult != ConnectivityResult.none) {
      try {
        showLoadingDialog();
        await profileApiService.updateUserProfile(
          accessToken: accessToken,
          fullname: fullname,
          email: email,
          nis: nis,
        );
        await getUserProfile();
        Get.back();
        showSuccessSnackbar(
          title: 'Berhasil',
          message: 'Profil berhasil diperbarui!',
        );
      } catch (e) {
        showErrorSnackbar(
          title: 'Gagal',
          message: 'Terjadi kesalahan saat memperbarui profil',
        );
      }
    }
  }

  logout() async {
    final connectivityResult = await ConnectivityHelper.checkConnection();

    if (connectivityResult != ConnectivityResult.none) {
      try {
        showLoadingDialog();
        await StorageService.removeAllExceptEmailAndRegisteredStatus();
        await Get.offAllNamed(Routes.LOGIN);
      } catch (e) {
        showErrorSnackbar(
          title: 'Logout Gagal',
          message: 'Terjadi kesalahan saat logout, silahkan coba lagi!',
        );
      }
    }
  }

  void getImageFromGallery() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      try {
        cropImage(image).then(
          (CroppedFile? croppedFile) {
            if (croppedFile != null) {
              updateAndGetUserPicture(
                XFile(croppedFile.path),
              );
            }
          },
        );
      } on Exception catch (e) {
        debugPrint('Error: $e');
      }
    }
  }

  void getImageFromCamera() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (image != null) {
      try {
        cropImage(image).then(
          (CroppedFile? croppedFile) {
            if (croppedFile != null) {
              updateAndGetUserPicture(
                XFile(croppedFile.path),
              );
            }
          },
        );
      } on Exception catch (e) {
        debugPrint('Error: $e');
      }
    }
  }

  Future<void> updateAndGetUserPicture(XFile croppedImageFile) async {
    try {
      await ApiService.updateUserPicture(
        file: File(croppedImageFile.path),
        accessToken: await StorageService.getAccessToken(),
      );
      await getUserProfile();
    } on Exception catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<CroppedFile?> cropImage(XFile file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Potong Gambar',
          toolbarColor: CustomColor.bankRumus,
          toolbarWidgetColor: CustomColor.whiteColor,
          statusBarColor: CustomColor.bankRumus,
          activeControlsWidgetColor: CustomColor.bankRumus,
          cropGridColor: CustomColor.bankRumus,
          aspectRatioPresets: const <CropAspectRatioPresetData>[
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );

    if (croppedFile != null) {
      return croppedFile;
    }

    return null;
  }
}
