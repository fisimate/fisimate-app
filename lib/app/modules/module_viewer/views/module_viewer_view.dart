import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:get/get.dart';

import '../controllers/module_viewer_controller.dart';

class ModuleViewerView extends GetView<ModuleViewerController> {
  const ModuleViewerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.bankSoal,
        title: Text(
          controller.examBank!.title,
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
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: CustomColor.bankSoal,
          ),
        ),
        child: const PDF(
          pageSnap: false,
        ).cachedFromUrl(controller.examBank!.filePath),
      ),
    );
  }
}
