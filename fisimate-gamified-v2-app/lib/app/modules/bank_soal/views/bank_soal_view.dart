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

import '../controllers/bank_soal_controller.dart';

class BankSoalView extends GetView<BankSoalController> {
  const BankSoalView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: CustomColor.bankSoal,
            title: Text(
              'Bank Soal',
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
                  child: Image.asset('assets/icons/yellow_arrow_left.png'),
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
                child: GetBuilder<BankSoalController>(
                  builder: (controller) {
                    if (controller.state.value == ResultState.initial) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: CustomColor.whiteColor,
                        ),
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomChip(label: '${controller.chapterCount} Bab'),
                          const Gap(CustomSize.marginLarge),
                          CustomChip(
                            label: '${controller.subChapterCount} Sub Bab',
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: CustomSize.marginLarge),
          ),
          GetBuilder<BankSoalController>(
            builder: (BankSoalController controller) {
              if (controller.state.value == ResultState.initial) {
                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: CustomColor.bankSoal,
                    ),
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: controller.chapterList.length,
                    (context, index) {
                      final subjectTitleItem = controller.chapterList[index].name;
                      final subjectDataItem = controller.chapterList[index].examBankSubChapters;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: CustomSize.marginLarge,
                            ),
                            child: CustomSubjectTitleWidget(
                              no: '0${index + 1}',
                              title: subjectTitleItem,
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
                                for (int index = 0; index < subjectDataItem.length; index++)
                                  Container(
                                    margin: index + 1 == subjectDataItem.length
                                        ? EdgeInsets.zero
                                        : const EdgeInsets.only(right: 10.0),
                                    child: CustomSubjectCard(
                                      assetPath: subjectDataItem[index].icon!,
                                      title: subjectDataItem[index].title,
                                      splashColor: CustomColor.bankRumus.withValues(alpha: 0.3),
                                      onTap: () => Get.toNamed(
                                        Routes.MODULE_VIEWER,
                                        arguments: {'type': 'exam_bank', 'data': subjectDataItem[index]},
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
