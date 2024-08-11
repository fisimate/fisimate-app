import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/modules/profile/controllers/profile_controller.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../theme/fonts.dart';

class EditProfileView extends GetView<ProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
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
              child: Image.asset(
                'assets/icons/arrow-back.png',
              ),
            ),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                          child: Obx(
                            () {
                              if (controller.imageState == ResultState.loading) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Shimmer(
                                    child: const CircleAvatar(
                                      radius: 80,
                                    ),
                                  ),
                                );
                              } else if (controller.imageState ==
                                  ResultState.hasData) {
                                return CircleAvatar(
                                  radius: 80,
                                  backgroundColor: CustomColor.yellowColor,
                                  backgroundImage:
                                      controller.userProfile.profilePicture !=
                                              null
                                          ? NetworkImage(
                                              controller
                                                  .userProfile.profilePicture!,
                                            )
                                          : const AssetImage(
                                              'assets/images/default/default_profile_photo.png',
                                            ) as ImageProvider,
                                );
                              } else {
                                return CircleAvatar(
                                  radius: 80,
                                  backgroundColor: CustomColor.yellowColor,
                                  backgroundImage:
                                      controller.userProfile.profilePicture !=
                                              null
                                          ? NetworkImage(
                                              controller
                                                  .userProfile.profilePicture!,
                                            )
                                          : const AssetImage(
                                              'assets/images/default/default_profile_photo.png',
                                            ) as ImageProvider,
                                );
                              }
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
                      child: Animate(
                        effects: const [
                          FadeEffect(
                            delay: Durations.medium1,
                            duration: Durations.medium1,
                          ),
                        ],
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
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        60, 31, 60, 23),
                                    child: Row(
                                      children: <Widget>[
                                        _buildBottomSheetItem(
                                          label: "Ambil Foto",
                                          iconPath:
                                              "assets/icons/profile/camera.svg",
                                          onTap: () {
                                            controller.getImageFromCamera();
                                            Get.back();
                                          },
                                        ),
                                        const Gap(20),
                                        _buildBottomSheetItem(
                                          label: "Pilih dari Galeri",
                                          iconPath:
                                              "assets/icons/profile/gallery.svg",
                                          onTap: () async {
                                            controller.getImageFromGallery();
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    ),
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
                  return Column(
                    children: <Widget>[
                      _buildProfileItem(
                        label: "Nama Panjang",
                        value: controller.userProfile.fullname ?? "",
                        controller: controller.nameController,
                      ),
                      const Gap(20),
                      _buildProfileItem(
                        label: "Nomor Induk Siswa (NIS)",
                        value: controller.userProfile.nis ?? "",
                        controller: controller.nisController,
                      ),
                      const Gap(20),
                      _buildProfileItem(
                        label: "Email",
                        value: controller.userProfile.email ?? "",
                        controller: controller.emailController,
                      ),
                      const Gap(20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: CustomFilledButton(
          text: "Simpan",
          onTap: controller.updateUserProfile,
        ),
      ),
    );
  }

  Expanded _buildBottomSheetItem({
    required String label,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: CustomColor.bottomSheetItemContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(iconPath),
                const Gap(13),
                Text(
                  label,
                  style: bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildProfileItem({
    required String label,
    required String value,
    required TextEditingController controller,
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
              Expanded(
                child: TextFormField(
                  controller: controller,
                  style: bodySemiBold.copyWith(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColor.bankRumus,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColor.bankRumus,
                      ),
                    ),
                  ),
                ),
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
