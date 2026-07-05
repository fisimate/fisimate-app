import 'package:fisimate/app/modules/main/simulation/simulation_content/controllers/simulation_content_controller.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SimulationMaterialSectionView extends GetView<SimulationContentController> {
  const SimulationMaterialSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: CustomSize.marginSmall,
        top: CustomSize.marginSmall,
        right: CustomSize.marginSmall,
        bottom: CustomSize.marginLarge,
      ),
      padding: const EdgeInsets.all(CustomSize.marginSmall),
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: CustomColor.blueColor,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF9747FF).withValues(alpha: 0.20),
            blurRadius: 3.3,
            spreadRadius: 1.65,
            offset: const Offset(1.65, 0.0),
          ),
        ],
      ),
      child: GetBuilder<SimulationContentController>(
        id: 'pdf_viewer',
        builder: (SimulationContentController controller) {
          if (controller.pdfFilePath.value.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: CustomColor.bankRumus,
              ),
            );
          } else if (controller.pdfFilePath.value == 'error') {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/images/not_found.png',
                    width: 100,
                    height: 100,
                  ),
                  const Gap(10),
                  Text(
                    'Materi tidak ditemukan',
                    style: poppinsMedium,
                  ),
                ],
              ),
            );
          } else {
            return PDF().cachedFromUrl(
              controller.pdfFilePath.value,
              placeholder: (double progress) => Center(
                child: CircularProgressIndicator(
                  value: progress,
                  color: CustomColor.blueColor,
                ),
              ),
              errorWidget: (dynamic error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/not_found.png',
                      width: 100,
                      height: 100,
                    ),
                    const Gap(10),
                    Text(
                      'Materi tidak ditemukan',
                      style: poppinsMedium,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
