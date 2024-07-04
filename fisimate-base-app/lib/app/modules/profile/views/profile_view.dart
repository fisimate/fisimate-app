import 'package:fisimate/app/routes/app_pages.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

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
      body: Column(
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
                    child: GetBuilder<ProfileController>(
                      id: "profile_photo",
                      builder: (context) {
                        return CircleAvatar(
                          radius: 45,
                          backgroundColor: CustomColor.yellowColor,
                          backgroundImage:
                              controller.userProfile.profilePicture != null
                                  ? NetworkImage(
                                      controller.userProfile.profilePicture!,
                                    )
                                  : const AssetImage(
                                      'assets/images/default/default_profile_photo.png',
                                    ) as ImageProvider,
                        );
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
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Email",
                                style: subHeadingSemiBold.copyWith(
                                  color: CustomColor.whiteColor,
                                ),
                              ),
                              Text(
                                "dafariski@gmail.com",
                                style: subHeadingRegular.copyWith(
                                  color: CustomColor.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: CustomColor.whiteColor,
                          thickness: 1,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "No Telepon",
                                  style: subHeadingSemiBold.copyWith(
                                    color: CustomColor.whiteColor,
                                  ),
                                ),
                                Text(
                                  "081234567890",
                                  style: subHeadingRegular.copyWith(
                                    color: CustomColor.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                ),
                const Gap(7),
                _buildListTile(
                  title: "Ubah Bahasa",
                ),
                const Gap(7),
                _buildListTile(
                  title: "Notifikasi",
                ),
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
                    return Dialog(
                      insetPadding: const EdgeInsets.symmetric(horizontal: 34),
                      backgroundColor: CustomColor.whiteColor,
                      surfaceTintColor: CustomColor.transparentColor,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Apakah Anda yakin ingin keluar?",
                              style: subHeadingRegular,
                              textAlign: TextAlign.center,
                            ),
                            const Gap(20),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => Get.back(),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: CustomColor.errorColor,
                                      backgroundColor: CustomColor.whiteColor,
                                      elevation: 0,
                                      side: BorderSide(
                                        color: CustomColor.errorColor,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                    ),
                                    child: Text(
                                      'Tidak',
                                      style: subHeadingBold,
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => controller.logout(),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: CustomColor.whiteColor,
                                      backgroundColor: CustomColor.greenColor,
                                      elevation: 0,
                                      side: BorderSide(
                                        color: CustomColor.greenColor,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                    ),
                                    child: Text(
                                      'Ya',
                                      style: subHeadingBold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              text: 'Logout',
              color: CustomColor.errorColor,
            ),
          ),
        ],
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
