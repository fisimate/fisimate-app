import 'package:fisimate_flutter_app/app/modules/main/simulation/simulation_content/controllers/simulation_content_controller.dart';
import 'package:fisimate_flutter_app/app/theme/colors.dart';
import 'package:fisimate_flutter_app/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';

class SimulationMaterialSectionView
    extends GetView<SimulationContentController> {
  const SimulationMaterialSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: CustomSize.marginSmall,
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
            color: Color(0xFF9747FF).withOpacity(0.20),
            blurRadius: 3.3,
            spreadRadius: 1.65,
            offset: const Offset(1.65, 0.0),
          ),
        ],
      ),
      child: PDF().cachedFromUrl(
        'http://47.236.10.27/storage/files/soal.pdf',
      ),
    );
  }
}
