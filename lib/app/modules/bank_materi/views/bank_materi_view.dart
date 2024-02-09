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
          body: GetBuilder<BankMateriController>(
              id: 'bank_materi',
              builder: (BankMateriController controller) {
                if (controller.state.value == ResultState.initial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.materialBankList!.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final subjectTitleItem =
                          controller.materialBankList![index].name;
                      final subjectDataItem =
                          controller.materialBankList![index].materialBanks;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: CustomSize.marginLarge),
                            child: CustomSubjectTitleWidget(
                                no: '0${index + 1}', title: subjectTitleItem!),
                          ),
                          const Gap(16.0),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(bottom: 6.0),
                            physics: const BouncingScrollPhysics(),
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
                                      onTap: () => Get.toNamed(
                                        Routes.MODULE_VIEWER,
                                        arguments: {
                                            'type': 'material_bank',
                                            'data': subjectDataItem[index]
                                          },
                                      ),
                                    ),
                                  ),
                                const Gap(CustomSize.marginLarge),
                              ],
                            ),
                          ),
                          const Gap(25.0)
                        ],
                      );
                    },
                  );
                }
              })),
    );
  }
}
