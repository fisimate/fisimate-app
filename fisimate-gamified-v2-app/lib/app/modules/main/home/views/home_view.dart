import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/data/responses/dashboard/get_available_chapter.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:fisimate/app/widgets/custom_header.dart';
import 'package:fisimate/app/widgets/custom_skeleton_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      HomeController(),
    );
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: Column(
        children: <Widget>[
          Gap(
            MediaQuery.of(context).padding.top,
          ),
          const Gap(CustomSize.marginMedium),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Obx(
                      () {
                        if (controller.userFirstName.isNotEmpty) {
                          return Text(
                            'Hai ${controller.userFirstName}!',
                            style: poppinsBold.copyWith(
                              fontSize: 26,
                              color: CustomColor.blackColor,
                            ),
                          );
                        } else {
                          return Text(
                            'Hai!',
                            style: poppinsBold.copyWith(
                              fontSize: 26,
                              color: CustomColor.blackColor,
                            ),
                          );
                        }
                      },
                    ),
                    Obx(
                      () {
                        if (controller.userProfilePhotoUrl.isNotEmpty) {
                          return CircleAvatar(
                            radius: 20,
                            backgroundColor: CustomColor.yellowColor,
                            backgroundImage: NetworkImage(
                              controller.userProfilePhotoUrl,
                            ),
                          );
                        } else {
                          return CircleAvatar(
                            radius: 20,
                            backgroundColor: CustomColor.yellowColor,
                            backgroundImage: const AssetImage(
                              "assets/images/default/default_profile_photo.png",
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                const Gap(22),
                const CustomHeader(),
              ],
            ),
          ),
          const Gap(CustomSize.marginMedium),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                _buildMenuItem(
                  label: 'Bank Rumus',
                  iconPath: "assets/images/bank_rumus.png",
                  color: CustomColor.bankRumus,
                  onTap: () {
                    Get.toNamed(Routes.BANK_RUMUS);
                  },
                ),
                const Gap(
                  CustomSize.marginSmall,
                ),
                _buildMenuItem(
                  label: 'Bank Materi',
                  iconPath: "assets/images/bank_materi.png",
                  color: const Color(0xFFFB9055),
                  onTap: () {
                    Get.toNamed(Routes.BANK_MATERI);
                  },
                ),
                const Gap(
                  CustomSize.marginSmall,
                ),
                _buildMenuItem(
                  label: 'Bank Soal',
                  iconPath: "assets/images/bank_soal.png",
                  color: CustomColor.orangeColor,
                  onTap: () {
                    Get.toNamed(Routes.BANK_SOAL);
                  },
                ),
                const Gap(
                  CustomSize.marginSmall,
                ),
                _buildMenuItem(
                  label: 'Leaderboard',
                  iconPath: "assets/images/leader_board.png",
                  color: CustomColor.darkGreenColor,
                  onTap: () {
                    Get.toNamed(Routes.LEADERBOARD);
                  },
                ),
              ],
            ),
          ),
          const Gap(CustomSize.marginMedium),
          Expanded(
            child: Obx(
              () {
                switch (controller.state) {
                  case ResultState.loading:
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return const CustomSkeletonWidget(
                          height: 160,
                        );
                      },
                    );
                  case ResultState.error:
                    return const Center(
                      child: Text('Error'),
                    );
                  case ResultState.hasData:
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: RefreshIndicator(
                        color: CustomColor.bankRumus,
                        backgroundColor: CustomColor.whiteColor,
                        onRefresh: () async {
                          await controller.getAvailableChapters();
                        },
                        child: ListView.builder(
                          itemCount: 3,
                          padding: const EdgeInsets.all(5),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final List<ChapterData> availableChapters = controller.availableChapters;
                            final ChapterData chapter = availableChapters[index];

                            return _buildTopicItem(
                              label: chapter.name,
                              description: chapter.shortDescription,
                              iconUrl: chapter.icon,
                              isMaterialBanksIsAvailable: chapter.materialBanks.isNotEmpty,
                              isFormulaBanksIsAvailable: chapter.formulaBanks.isNotEmpty,
                              isExamBanksIsAvailable: chapter.examBanks.isNotEmpty,
                              isExperimentsIsAvailable: chapter.simulations.isNotEmpty,
                            );
                          },
                        ),
                      ),
                    );
                  case ResultState.initial:
                    return const SizedBox.shrink();
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTopicItem({
    required String label,
    required String description,
    required String iconUrl,
    required bool isMaterialBanksIsAvailable,
    required bool isFormulaBanksIsAvailable,
    required bool isExamBanksIsAvailable,
    required bool isExperimentsIsAvailable,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.circular(
          CustomSize.roundedMedium,
        ),
        border: Border.all(
          color: CustomColor.bankRumus,
          width: 1.0,
        ),
        boxShadow: CustomColor.bankItemShadow,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Image.network(
              iconUrl,
            ),
          ),
          const Gap(15),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: poppinsBold.copyWith(
                    fontSize: 14,
                    color: CustomColor.blackColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  description,
                  style: poppinsRegular.copyWith(
                    fontSize: 12,
                    color: CustomColor.blackColor,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(8),
                Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  spacing: 5,
                  runSpacing: 5,
                  children: <Widget>[
                    isFormulaBanksIsAvailable == true
                        ? _buildAvaibilityItem(
                            label: 'Bank Rumus',
                            color: CustomColor.blueColor,
                          )
                        : const SizedBox.shrink(),
                    isMaterialBanksIsAvailable == true
                        ? _buildAvaibilityItem(
                            label: 'Bank Materi',
                            color: const Color(0xFFFB9055),
                          )
                        : const SizedBox.shrink(),
                    isExamBanksIsAvailable == true
                        ? _buildAvaibilityItem(
                            label: 'Bank Soal',
                            color: CustomColor.orangeColor,
                          )
                        : const SizedBox.shrink(),
                    isExperimentsIsAvailable == true
                        ? _buildAvaibilityItem(
                            label: 'Simulasi',
                            color: CustomColor.purpleColor,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildMenuItem({
    required String label,
    required String iconPath,
    required Color color,
    required Function() onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashFactory: InkRipple.splashFactory,
        borderRadius: BorderRadius.circular(
          CustomSize.roundedMedium,
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: Ink(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(
                CustomSize.roundedMedium,
              ),
              boxShadow: CustomColor.mainMenuItemShadow,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  iconPath,
                  height: 40,
                ),
                const Gap(6),
                Text(
                  label,
                  style: poppinsMedium.copyWith(
                    color: CustomColor.whiteColor,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildAvaibilityItem({
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          CustomSize.roundedLarge,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.check,
            size: 15,
            color: CustomColor.whiteColor,
          ),
          const Gap(5),
          Text(
            label,
            style: poppinsMedium.copyWith(
              color: CustomColor.whiteColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
