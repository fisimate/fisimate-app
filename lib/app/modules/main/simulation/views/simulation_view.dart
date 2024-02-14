import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:fisimate/app/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controllers/simulation_controller.dart';

class SimulationView extends GetView<SimulationController> {
  const SimulationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SimulationController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Simulasi",
          style: titleBold.copyWith(
            color: CustomColor.blueColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: CustomSize.marginLarge),
        child: Column(
          children: [
            buildHeader(),
            const Gap(18),
            CustomSearchBar(
              hint: "Cari",
              prefix: Icon(
                Icons.search,
                color: CustomColor.greyColor,
              ),
              suffix: const Icon(Icons.tune),
            ),
            const Gap(32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Pembelajaran Terakhir",
                  style: bodySemiBold.copyWith(fontSize: 12),
                ),
                const Gap(10),
                Expanded(
                  child: Container(
                    height: 2,
                    color: CustomColor.blackColor,
                  ),
                )
              ],
            ),
            const Gap(10),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  List<Map<String, dynamic>> simulationItem = [
                    {
                      'label': 'GLBB',
                      'imagePath': 'assets/icons/blue-car.png',
                      'progress': 80,
                    },
                    {
                      'label': 'Titik Berat',
                      'imagePath': 'assets/icons/scales.png',
                      'progress': 20,
                    },
                    {
                      'label': 'Hukum Pascal',
                      'imagePath': 'assets/icons/gas-cable.png',
                      'progress': 54,
                    },
                  ];
                  return _buildSimulationItem(
                    label: simulationItem[index]['label'],
                    imagePath: simulationItem[index]['imagePath'],
                    progress: simulationItem[index]['progress'],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.orangeColor.withOpacity(0.7),
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
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Eksplorasi\nInteraktif',
                      style: titleBold.copyWith(
                        fontSize: 23,
                        color: CustomColor.whiteColor,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      'Sentuh, putar, dan amati setiap percobaan untuk mendapatkan pemahaman yang mendalam.',
                      style: poppinsRegular.copyWith(
                        fontSize: 12,
                        color: CustomColor.whiteColor,
                      ),
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/simulation_header.png",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildSimulationItem({
    required String label,
    required int progress,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: CustomColor.blueColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Image.asset(
              imagePath,
            ),
          ),
          const Gap(15),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "Simulasi $label",
                      style: poppinsBold.copyWith(
                        fontSize: 14,
                        color: CustomColor.blackColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: CustomColor.blueColor,
                      size: 12,
                    )
                  ],
                ),
                const Gap(4),
                Text(
                  "Progress Pembelajaran",
                  style: bodyRegular.copyWith(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                const Gap(8),
                LinearPercentIndicator(
                  lineHeight: 10,
                  padding: const EdgeInsets.all(0),
                  // progressColor: CustomColor.blueColor,
                  linearGradient: LinearGradient(colors: [
                    CustomColor.bankRumus,
                    CustomColor.yellowColor,
                  ]),
                  backgroundColor: Colors.grey.shade100,
                  percent: (progress / 100).toDouble(),
                  animation: false,
                  barRadius: const Radius.circular(50),
                ),
                const Gap(6),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "3 dari 3",
                    style: bodyRegular.copyWith(color: CustomColor.blueColor),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
