import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/widgets/base_dialog.dart';
import 'package:fisimate/app/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ProfileController(),
    );
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: RefreshIndicator(
        displacement: 70,
        backgroundColor: CustomColor.whiteColor,
        color: CustomColor.blueColor,
        onRefresh: () async {
          controller.getUserProfile();
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: CustomColor.bankRumus,
                height: MediaQuery.of(context).padding.top,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CustomColor.bankRumus,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(38),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    const Gap(11),
                    Hero(
                      tag: "profile_photo",
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Obx(
                          () {
                            if (controller.state == ResultState.loading) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Shimmer(
                                  child: const CircleAvatar(
                                    radius: 45,
                                  ),
                                ),
                              );
                            } else if (controller.state == ResultState.hasData) {
                              return CircleAvatar(
                                radius: 45,
                                backgroundColor: CustomColor.yellowColor,
                                backgroundImage: controller.userProfile.profilePicture != null
                                    ? NetworkImage(
                                        controller.userProfile.profilePicture!,
                                      )
                                    : const AssetImage(
                                            'assets/images/default/default_profile_photo.png',
                                          )
                                          as ImageProvider,
                              );
                            } else {
                              return CircleAvatar(
                                radius: 45,
                                backgroundColor: CustomColor.yellowColor,
                                backgroundImage: controller.userProfile.profilePicture != null
                                    ? NetworkImage(
                                        controller.userProfile.profilePicture!,
                                      )
                                    : const AssetImage(
                                            'assets/images/default/default_profile_photo.png',
                                          )
                                          as ImageProvider,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    const Gap(6),
                    Obx(
                      () => Text(
                        controller.userProfile.fullname ?? "",
                        style: titleBold.copyWith(
                          color: CustomColor.whiteColor,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller.userProfile.nis ?? "",
                        style: subHeadingRegular.copyWith(
                          color: CustomColor.whiteColor,
                        ),
                      ),
                    ),
                    const Gap(22.5),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Email",
                                  style: subHeadingSemiBold.copyWith(
                                    color: CustomColor.whiteColor,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    controller.userProfile.email ?? "",
                                    style: subHeadingRegular.copyWith(
                                      color: CustomColor.whiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(34),
                  ],
                ),
              ),
              const Gap(46),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Pengaturan Akun",
                      style: subHeadingBold,
                    ),
                    const Gap(7),
                    _buildListTile(
                      title: "Ubah Profil",
                      onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
                    ),
                    const Gap(7),
                    _buildListTile(
                      title: "Ubah Kata Sandi",
                      onTap: () => Get.toNamed(Routes.EDIT_PASSWORD),
                    ),
                    // const Gap(7),
                    // _buildListTile(
                    //   title: "Ubah Bahasa",
                    // ),
                    // const Gap(7),
                    // _buildListTile(
                    //   title: "Notifikasi",
                    // ),
                    const Gap(21),
                    _buildListTile(
                      title: "Pusat Bantuan",
                    ),
                    const Gap(7),
                    _buildListTile(
                      title: "Kebijakan Privasi",
                    ),
                    const Gap(7),
                    _buildListTile(
                      title: "Ketentuan Penggunaan",
                    ),
                    const Gap(7),
                    _buildListTile(
                      title: "Laporkan Masalah",
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: CustomFilledButton(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BaseDialog(
                          text: "Apakah Anda yakin ingin keluar?",
                          onConfirm: () {
                            controller.logout();
                            // Get.offAllNamed(Routes.LOGIN);
                          },
                          onCancel: () => Get.back(),
                        );
                      },
                    );
                  },
                  text: 'Logout',
                  color: CustomColor.errorColor,
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    VoidCallback? onTap,
  }) {
    onTap ??= () {};
    return InkWell(
      onTap: onTap,
      splashFactory: InkRipple.splashFactory,
      child: Ink(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Gap(7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: subHeadingRegular,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                  color: CustomColor.blackColor,
                ),
              ],
            ),
            const Gap(7),
            Divider(
              color: CustomColor.darkGreyColor,
              thickness: 0.5,
              height: 0,
            ),
          ],
        ),
      ),
    );
  }
}
