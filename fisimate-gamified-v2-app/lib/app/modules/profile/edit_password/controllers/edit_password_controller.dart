import 'package:fisimate/app/config/services/profile_api_service.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditPasswordController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ResultState _resultState = ResultState.initial;
  ResultState get resultState => _resultState;

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController get oldPasswordController => _oldPasswordController;

  FocusNode _oldPasswordFocusNode = FocusNode();
  FocusNode get oldPasswordFocusNode => _oldPasswordFocusNode;

  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController get newPasswordController => _newPasswordController;

  FocusNode _newPasswordFocusNode = FocusNode();
  FocusNode get newPasswordFocusNode => _newPasswordFocusNode;

  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  FocusNode _confirmPasswordFocusNode = FocusNode();
  FocusNode get confirmPasswordFocusNode => _confirmPasswordFocusNode;

  Future<void> changePassword() async {
    ProfileApiService profileApiService = ProfileApiService();

    try {
      _resultState = ResultState.loading;
      update();

      final dynamic response = await profileApiService.updateUserPassword(
        accessToken: await StorageService.getAccessToken(),
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        passwordConfirmation: confirmPasswordController.text,
      );

      if (response is String) {
        throw Exception(response);
      }

      _resultState = ResultState.hasData;
      update();
      showSuccessSnackbar(
        title: 'Berhasil',
        message: 'Kata sandi berhasil diubah',
      );
    } catch (e) {
      _resultState = ResultState.error;
      update();
      showErrorSnackbar(
        title: 'Gagal',
        message: e.toString(),
      );
    } finally {
      _resultState = ResultState.initial;
      unfocusAll();
      clearAll();
    }
  }

  void unfocusAll() {
    oldPasswordFocusNode.unfocus();
    newPasswordFocusNode.unfocus();
    confirmPasswordFocusNode.unfocus();
  }

  void clearAll() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    formKey.currentState!.reset();
  }

  bool _isOldPasswordObscure = true;
  bool get isOldPasswordObscure => _isOldPasswordObscure;

  void toggleIsOldPasswordObscure() {
    _isOldPasswordObscure = !_isOldPasswordObscure;
    update(['old_password']);
  }

  bool _isNewPasswordObscure = true;
  bool get isNewPasswordObscure => _isNewPasswordObscure;

  void toggleIsNewPasswordObscure() {
    _isNewPasswordObscure = !_isNewPasswordObscure;
    update(['new_password']);
  }

  bool _isConfirmPasswordObscure = true;
  bool get isConfirmPasswordObscure => _isConfirmPasswordObscure;

  void toggleIsConfirmPasswordObscure() {
    _isConfirmPasswordObscure = !_isConfirmPasswordObscure;
    update(['confirm_password']);
  }
}
