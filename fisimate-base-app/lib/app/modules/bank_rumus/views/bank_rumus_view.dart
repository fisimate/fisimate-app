import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:fisimate/app/widgets/custom_chip.dart';
import 'package:fisimate/app/widgets/custom_subject_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/bank_rumus_controller.dart';

class BankRumusView extends GetView<BankRumusController> {
  const BankRumusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: CustomColor.bankRumus,
            title: Text(
              'Bank Rumus',
              style: headingBold.copyWith(
                color: CustomColor.whiteColor,
              ),
            ),
            pinned: true,
            centerTitle: true,
            automaticallyImplyLeading: false,
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
              onPressed: () {
                Get.back();
              },
            ),
            expandedHeight: 130,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: const EdgeInsets.only(top: 80),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomChip(label: '3 Kelas'),
                    CustomChip(label: '20 Bab'),
                    CustomChip(label: '150 Soal')
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: CustomSize.marginLarge),
          ),
          GetBuilder<BankRumusController>(
            id: 'bank_rumus',
            builder: (BankRumusController controller) {
              if (controller.state.value == ResultState.initial) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final subjectTitleItem =
                          controller.formulaBankList![index].name;
                      final subjectDataItem =
                          controller.formulaBankList![index].formulaBanks;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: CustomSize.marginLarge,
                            ),
                            child: CustomSubjectTitleWidget(
                              no: '0${index + 1}',
                              title: subjectTitleItem!,
                            ),
                          ),
                          const Gap(16.0),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(bottom: 6.0),
                            // physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                const Gap(CustomSize.marginLarge),
                                for (int index = 0;
                                    index < subjectDataItem!.length;
                                    index++)
                                  Container(
                                    margin: index + 1 == subjectDataItem.length
                                        ? EdgeInsets.zero
                                        : const EdgeInsets.only(right: 10.0),
                                    child: CustomSubjectCard(
                                      assetPath: subjectDataItem[index].icon!,
                                      title: subjectDataItem[index].title!,
                                      splashColor: CustomColor.bankRumus
                                          .withOpacity(0.3),
                                      onTap: () => Get.toNamed(
                                        Routes.MODULE_VIEWER,
                                        arguments: {
                                          'type': 'formula_bank',
                                          'data': subjectDataItem[index]
                                        },
                                      ),
                                    ),
                                  ),
                                const Gap(CustomSize.marginLarge),
                              ],
                            ),
                          ),
                          const Gap(25.0),
                        ],
                      );
                    },
                    childCount: controller.formulaBankList!.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
