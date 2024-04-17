import 'package:fisimate/app/modules/main/simulation/simulation_content/controllers/simulation_content_controller.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

final List<String> listOfRules = [
  "Masukan kecepatan awal (v)",
  "Masukan waktu tempuh (t)",
  "Masukan percepatan (a)",
  "Klik tombol mulai",
];

class SimulationSimulationSectionView
    extends GetView<SimulationContentController> {
  const SimulationSimulationSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: CustomSize.marginSmall,
        ),
        child: Column(
          children: <Widget>[
            Text(
              "Mencari jarak tempuh",
              style: headingBold,
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.all(
                CustomSize.marginSmall,
              ),
              decoration: BoxDecoration(
                color: CustomColor.seaBlueColor,
                border: Border.all(
                  color: CustomColor.blueColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(
                  CustomSize.roundedLarge,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: CustomColor.blackColor.withOpacity(0.09),
                    blurRadius: 7.8,
                    spreadRadius: 0,
                    offset: const Offset(3.0, 1.0),
                  ),
                  BoxShadow(
                    color: CustomColor.blackColor.withOpacity(0.17),
                    blurRadius: 4.8,
                    spreadRadius: 0,
                    offset: const Offset(2.0, 1.0),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.info,
                    size: 20,
                    color: CustomColor.pinkColor,
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Petunjuk pengerjaan",
                        style: subHeadingRegular.copyWith(
                          color: CustomColor.pinkColor,
                        ),
                      ),
                      const Gap(5),
                      for (int i = 0; i < listOfRules.length; i++)
                        Text(
                          "${i + 1}. ${listOfRules[i]}",
                          style: bodyRegular,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(10),
            Column(
              children: <Widget>[
                Image.asset(
                  "assets/images/dummy_simulation.png",
                  fit: BoxFit.contain,
                ),
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildSimulationInputForm(
                          title: "Kecepatan",
                          unit: "m/s",
                        ),
                        const Gap(18),
                        _buildSimulationInputForm(
                          title: "Waktu awal",
                          unit: "s",
                        ),
                        const Gap(18),
                        _buildSimulationInputForm(
                          title: "Percepatan",
                          unit: "m/s^2",
                        ),
                      ],
                    ),
                    IconButton.filled(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          CustomColor.bankRumus,
                        ),
                      ),
                      icon: const Icon(
                        Icons.play_arrow_rounded,
                        size: 45,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Row _buildSimulationInputForm({
    required String title,
    required String unit,
  }) {
    return Row(
      children: <Widget>[
        Text(
          title,
        ),
        const Gap(10),
        Row(
          children: <Widget>[
            const Text(
              ":",
            ),
            const Gap(10),
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      CustomSize.roundedMedium,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColor.blackColor.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxWidth: 70,
                      ),
                      filled: true,
                      fillColor: CustomColor.whiteColor,
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          CustomSize.roundedMedium,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Text(
                  unit,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
