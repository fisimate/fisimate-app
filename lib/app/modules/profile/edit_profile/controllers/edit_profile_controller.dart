import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  Rx<XFile> imageFile = XFile('').obs;

  void getImageFromGallery() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile.value = image;
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
