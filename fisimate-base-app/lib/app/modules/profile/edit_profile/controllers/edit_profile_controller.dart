import 'dart:io';

import 'package:fisimate/app/config/services/api_services.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  Rx<XFile> imageFile = XFile('').obs;

  void getImageFromGallery() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      imageFile.value = image;
      try {
        ApiService.updateUserPicture(
          file: File(image.path),
          accessToken: await StorageService.getAccessToken(),
        );
      } on Exception catch (e) {
        debugPrint('Error: $e');
      }
    }
  }

  void getImageFromCamera() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      imageFile.value = image;
    }
  }
}
