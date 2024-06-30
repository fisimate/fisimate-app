import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';

import '../controllers/module_viewer_controller.dart';

class ModuleViewerView extends GetView<ModuleViewerController> {
  const ModuleViewerView({super.key});
  
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {};

    switch (controller.argumentType.value) {
      case 'exam_bank':
        data = {
          'title': controller.examBankElement!.title,
          'filePath': controller.examBankElement!.filePath,
          'color': CustomColor.bankSoal,
        };
        break;
      case 'material_bank':
        data = {
          'title': controller.materialBankElement!.title!,
          'filePath': controller.materialBankElement!.filePath!,
          'color': CustomColor.bankMateri,
        };
        break;
      case 'formula_bank':
        data = {
          'title': controller.formulaBankElement!.title!,
          'filePath': controller.formulaBankElement!.filePath!,
          'color': CustomColor.bankRumus,
        };
        break;
      default:
    }
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      appBar: AppBar(
        backgroundColor: data['color'],
        title: Text(
          data['title'],
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
      body: Container(
        margin: const EdgeInsets.all(CustomSize.marginSmall),
        padding: const EdgeInsets.all(CustomSize.marginSmall),
        decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: data['color'],
          ),
        ),
        child: const PDF(
          pageSnap: false,
        ).cachedFromUrl(data['filePath']),
      ),
    );
  }
}
