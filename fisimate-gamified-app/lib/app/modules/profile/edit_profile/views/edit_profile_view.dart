import 'package:fisimate_flutter_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:fisimate_flutter_app/app/theme/colors.dart';
import 'package:fisimate_flutter_app/app/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../../theme/fonts.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();
    EditProfileController controller = Get.find<EditProfileController>();
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColor.bankRumus,
        title: Text(
          "Ubah Profil",
          style: headingBold.copyWith(
            color: CustomColor.whiteColor,
          ),
        ),
        leading: IconButton(
          icon: CircleAvatar(
            radius: 16,
            backgroundColor: CustomColor.whiteColor,
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Image.asset('assets/icons/arrow-back.png'),
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.13 + 80 + 20,
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  decoration: BoxDecoration(
                    color: CustomColor.bankRumus,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(67),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Center(
                    child: Hero(
                      tag: "profile_photo",
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: CustomColor.greyColor.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: GetBuilder<ProfileController>(
                          builder: (context) {
                            return CircleAvatar(
                              radius: 80,
                              backgroundColor: CustomColor.yellowColor,
                              backgroundImage: profileController
                                          .userProfile.profilePicture !=
                                      null
                                  ? NetworkImage(
                                      profileController
                                          .userProfile.profilePicture!,
                                    )
                                  : const AssetImage(
                                      "assets/images/default/default_profile_photo.png",
                                    ) as ImageProvider,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.greyColor.withOpacity(0.5),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: IconButton.filled(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: CustomColor.whiteColor,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    title: const Text("Ambil Foto"),
                                    onTap: () {
                                      controller.getImageFromCamera();
                                      Get.back();
                                    },
                                  ),
                                  ListTile(
                                    title: const Text("Pilih dari Galeri"),
                                    onTap: () async {
                                      controller.getImageFromGallery();
                                      Get.back();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: CustomColor.whiteColor,
                        ),
                        icon: Icon(
                          Icons.edit_outlined,
                          color: CustomColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(46),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Obx(
              () {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _buildProfileItem(
                        label: "Nama Panjang",
                        value: profileController.userProfile.fullname ?? "",
                      ),
                      const Gap(20),
                      _buildProfileItem(
                        label: "Kelas",
                        value: profileController.userProfile.role?.name ?? "",
                      ),
                      const Gap(20),
                      _buildProfileItem(
                        label: "Email",
                        value: profileController.userProfile.email ?? "",
                      ),
                      const Gap(20),
                      _buildProfileItem(
                        label: "No Telepon",
                        value: profileController.userProfile.nis ?? "",
                      ),
                      const Gap(20),
                    ],
                  ),
                );
              }
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: CustomFilledButton(
          text: "Simpan",
          onTap: () {},
        ),
      ),
    );
  }

  Container _buildProfileItem({
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    onTap ??= () {};
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: CustomColor.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: CustomColor.blackColor.withOpacity(0.06),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color: CustomColor.blackColor.withOpacity(0.10),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: bodyRegular.copyWith(
              color: CustomColor.greyColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                value,
                style: subHeadingSemiBold,
              ),
              GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.edit_outlined,
                  color: CustomColor.bankRumus,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
