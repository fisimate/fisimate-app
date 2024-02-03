import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:fisimate/app/widgets/custom_chip.dart';
import 'package:fisimate/app/widgets/custom_subject_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/bank_materi_controller.dart';

class BankMateriView extends GetView<BankMateriController> {
  const BankMateriView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: CustomColor.bankMateri,
              title: Text(
                'Bank Materi',
                style: headingBold.copyWith(color: CustomColor.whiteColor),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
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
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    width: CustomSize.maxWidth,
                    height: CustomSize.maxHeight / 10,
                    decoration: BoxDecoration(color: CustomColor.bankMateri),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomChip(label: '3 Kelas'),
                        Gap(10.0),
                        CustomChip(label: '20 Bab'),
                        Gap(10.0),
                        CustomChip(label: '150 Soal')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: const Padding(
          padding: EdgeInsets.all(CustomSize.marginLarge),
          child: Column(
            children: [
              CustomSubjectTitleWidget(
                no: '01',
                title: 'Keseimbangan Benda',
              ),
              Gap(16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(bottom: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSubjectCard(
                      assetPath: 'assets/icons/scales.png',
                      title: 'Keseimbangan',
                    ),
                    Gap(10.0),
                    CustomSubjectCard(
                      assetPath: 'assets/icons/magnetic.png',
                      title: 'Momen Gaya',
                    ),
                    Gap(10.0),
                    CustomSubjectCard(
                      assetPath: 'assets/icons/dart.png',
                      title: 'Momen Gaya',
                    ),
                    Gap(10.0),
                    CustomSubjectCard(
                      assetPath: 'assets/icons/judges-gavel.png',
                      title: 'Momen Gaya',
                    ),
                  ],
                ),
              ),
              Gap(25.0),
              CustomSubjectTitleWidget(
                no: '02',
                title: 'Dinamika Rotasi',
              ),
              Gap(16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(bottom: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSubjectCard(
                      assetPath: 'assets/icons/round-red-figure.png',
                      title: 'Momen Inersia',
                    ),
                    Gap(10.0),
                    CustomSubjectCard(
                      assetPath: 'assets/icons/blue-car.png',
                      title: 'Hukum Newton',
                    ),
                    Gap(10.0),
                    CustomSubjectCard(
                      assetPath: 'assets/icons/carpenter-ruler.png',
                      title: 'Usaha dan Energi',
                    ),
                    Gap(10.0),
                    CustomSubjectCard(
                      assetPath: 'assets/icons/autism.png',
                      title: 'Momentum Sudut',
                    ),
                    Gap(10.0),
                    CustomSubjectCard(
                      assetPath: 'assets/icons/judges-gavel.png',
                      title: 'Momen Integral',
                    ),
                  ],
                ),
              ),
              Gap(25.0),
              CustomSubjectTitleWidget(
                no: '03',
                title: 'Fluida',
              ),
              Gap(16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(bottom: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSubjectCard(
                      assetPath: 'assets/icons/tonometer.png',
                      title: 'Tekanan',
                    ),
                    Gap(10.0),
                    CustomSubjectCard(
                      assetPath: 'assets/icons/hookah.png',
                      title: 'Hukum Pascal',
                    ),
                    Gap(10.0),
                    CustomSubjectCard(
                      assetPath: 'assets/icons/blue-car.png',
                      title: 'Hukum Archimedes',
                    ),
                    Gap(10.0),
                    CustomSubjectCard(
                      assetPath: 'assets/icons/autism.png',
                      title: 'Aplikasi Hukum Archimedes',
                    ),
                    Gap(10.0),
                    CustomSubjectCard(
                      assetPath: 'assets/icons/judges-gavel.png',
                      title: 'Momen Integral',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
