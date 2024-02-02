import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Gap(
            MediaQuery.of(context).padding.top,
          ),
          const Gap(20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Hai Nabila!',
                      style: poppinsBold.copyWith(
                        fontSize: 30,
                        color: CustomColor.blackColor,
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: CustomColor.yellowColor,
                      backgroundImage: const AssetImage(
                        "assets/images/dummy_profile_photo.png",
                      ),
                    ),
                  ],
                ),
                const Gap(22),
                Container(
                  decoration: BoxDecoration(
                    color: CustomColor.yellowColor,
                    borderRadius: BorderRadius.circular(
                      CustomSize.roundedMedium,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 17.5,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 30,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Eksplorasi\nInteraktif',
                                  style: poppinsSemiBold.copyWith(
                                    fontSize: 23,
                                    color: CustomColor.blackColor,
                                  ),
                                ),
                                const Gap(6),
                                Text(
                                  'Sentuh, putar, dan amati setiap percobaan untuk mendapatkan pemahaman yang mendalam.',
                                  style: poppinsRegular.copyWith(
                                    fontSize: 12,
                                    color: CustomColor.blackColor,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/header.png",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(18),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                _buildMenuItem(
                  label: 'Bank Rumus',
                  iconPath: "assets/images/bank_rumus.png",
                  color: CustomColor.blueColor,
                ),
                const Gap(
                  CustomSize.marginSmall,
                ),
                _buildMenuItem(
                  label: 'Bank Materi',
                  iconPath: "assets/images/bank_materi.png",
                  color: const Color(0xFFFB9055),
                ),
                const Gap(
                  CustomSize.marginSmall,
                ),
                _buildMenuItem(
                  label: 'Bank Soal',
                  iconPath: "assets/images/bank_soal.png",
                  color: CustomColor.orangeColor,
                ),
                const Gap(
                  CustomSize.marginSmall,
                ),
                _buildMenuItem(
                  label: 'Leader Board',
                  iconPath: "assets/images/leader_board.png",
                  color: CustomColor.greenColor,
                ),
              ],
            ),
          ),
          const Gap(13),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                itemCount: 3,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  List<Map<String, dynamic>> topics = [
                    {
                      'label': 'Gerak Lurus',
                      'description':
                          'Visualisasikan dan pahami konsep pergerakan benda dalam lintasan lurus',
                      'iconPath': "icon path goes here", // !TODO: add icon path
                      'isMaterialAvailable': true,
                      'isExperimentAvailable': false,
                      'isQuizAvailable': true,
                    },
                    {
                      'label': 'Kesetimbangan Benda',
                      'description':
                          'Simulasikan bagaimana gaya dapat mempengaruhi pergeseran benda',
                      'iconPath': "icon path goes here", // !TODO: add icon path
                      'isMaterialAvailable': false,
                      'isExperimentAvailable': true,
                      'isQuizAvailable': true,
                    },
                    {
                      'label': 'Usaha dan Energi',
                      'description':
                          'Explorasi sebuah usaha pada benda dapat mengubah bentuk-bentuk energi',
                      'iconPath': "icon path goes here", // !TODO: add icon path
                      'isMaterialAvailable': true,
                      'isExperimentAvailable': true,
                      'isQuizAvailable': true,
                    },
                  ];

                  return _buildTopicItem(
                    label: topics[index]['label'],
                    description: topics[index]['description'],
                    iconPath: topics[index]['iconPath'],
                    isMaterialAvailable: topics[index]['isMaterialAvailable'],
                    isExperimentAvailable:
                        topics[index]['isExperimentAvailable'],
                    isQuizAvailable: topics[index]['isQuizAvailable'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTopicItem({
    required String label,
    required String description,
    required String iconPath,
    required bool isMaterialAvailable,
    required bool isExperimentAvailable,
    required bool isQuizAvailable,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.circular(
          CustomSize.roundedMedium,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            spreadRadius: 0,
            blurRadius: 7.8,
            offset: const Offset(1, 3),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.21),
            spreadRadius: 0,
            blurRadius: 4.8,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          const Expanded(
            flex: 2,
            child: FlutterLogo(
              size: 50,
            ),
          ),
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
                ),
                const Gap(6),
                Text(
                  description,
                  style: poppinsRegular.copyWith(
                    fontSize: 12,
                    color: CustomColor.blackColor,
                  ),
                ),
                const Gap(10),
                Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  spacing: 5,
                  runSpacing: 5,
                  children: <Widget>[
                    isMaterialAvailable == true ? _buildAvaibilityItem(
                      label: 'Materi',
                      color: CustomColor.blueColor,
                    ) : const SizedBox.shrink(),
                    isExperimentAvailable == true ? _buildAvaibilityItem(
                      label: 'Percobaan',
                      color: const Color(0xFFFB9055),
                    ) : const SizedBox.shrink(),
                    isQuizAvailable == true ? _buildAvaibilityItem(
                      label: 'Kuis',
                      color: CustomColor.orangeColor,
                    ) : const SizedBox.shrink(),
                  ],
                )
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
  }) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              CustomSize.roundedMedium,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                iconPath,
              ),
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
