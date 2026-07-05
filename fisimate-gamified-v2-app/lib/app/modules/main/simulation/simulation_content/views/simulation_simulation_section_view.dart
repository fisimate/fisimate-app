import 'package:fisimate/app/modules/game/controllers/game_controller.dart';
import 'package:fisimate/app/modules/game/views/game_view.dart';
import 'package:fisimate/app/modules/main/simulation/simulation_content/controllers/simulation_content_controller.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:fisimate/app/widgets/custom_simulation_navigator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

final List<String> listOfGuidelinesGlb = [
  "Masukan jarak tempuh (s)",
  "Masukan waktu tempuh (t)",
  "Klik tombol mulai",
];

final List<String> listOfGuidelinesFriction = [
  "Masukan gaya dorong (F)",
  "Masukan koefisien gesekan (μ)",
  "Masukan massa benda (m)",
  "Klik tombol mulai",
];

class SimulationSimulationSectionView extends GetView<SimulationContentController> {
  const SimulationSimulationSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Get.arguments['gameScene'] != null
        ? _buildGameAvailable()
        : Center(
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
                  'Simulasi tidak ditemukan',
                  style: poppinsMedium,
                ),
              ],
            ),
          );
  }

  SingleChildScrollView _buildGameAvailable() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: CustomSize.marginSmall,
        ),
        child: Column(
          children: <Widget>[
            Get.arguments['gameScene'] != null
                ? Text(
                    Get.arguments['gameScene'] == "GLB" ? "Mencari Perpindahan Balok Kayu" : "Mencari Kecepatan Mobil",
                    style: headingBold,
                  )
                : const SizedBox(),
            Get.arguments['gameScene'] != null ? const Gap(20) : const SizedBox.shrink(),
            Get.arguments['gameScene'] != null
                ? Container(
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
                          color: CustomColor.blackColor.withValues(alpha: 0.09),
                          blurRadius: 7.8,
                          spreadRadius: 0,
                          offset: const Offset(3.0, 1.0),
                        ),
                        BoxShadow(
                          color: CustomColor.blackColor.withValues(alpha: 0.17),
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
                        Get.arguments['gameScene'] == "GLB"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Petunjuk pengerjaan",
                                    style: subHeadingRegular.copyWith(
                                      color: CustomColor.pinkColor,
                                    ),
                                  ),
                                  const Gap(5),
                                  for (int i = 0; i < listOfGuidelinesFriction.length; i++)
                                    Text(
                                      "${i + 1}. ${listOfGuidelinesFriction[i]}",
                                      style: bodyRegular,
                                    ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Petunjuk pengerjaan",
                                    style: subHeadingRegular.copyWith(
                                      color: CustomColor.pinkColor,
                                    ),
                                  ),
                                  const Gap(5),
                                  for (int i = 0; i < listOfGuidelinesGlb.length; i++)
                                    Text(
                                      "${i + 1}. ${listOfGuidelinesGlb[i]}",
                                      style: bodyRegular,
                                    ),
                                ],
                              ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            const Gap(10),
            Column(
              children: <Widget>[
                const GameView(),
                const Gap(10),
                GetBuilder<GameController>(
                  builder: (GameController gameController) {
                    if (gameController.gameSceneName.value == "GLB") {
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: BaseElevatedButton.icon(
                              iconData: Icons.arrow_back_ios,
                              backgroundColor: CustomColor.bankRumus,
                              foregroundColor: CustomColor.whiteColor,
                              label: "Dorong ke kiri",
                              style: BaseElevatedButtonStyle.withPrefixIcon,
                              onPressed: () {
                                gameController.setDisplacementDirection(DisplacementDirection.left);
                                gameController.startBlockMovement();
                              },
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            child: BaseElevatedButton.icon(
                              iconData: Icons.arrow_forward_ios,
                              backgroundColor: CustomColor.bankRumus,
                              foregroundColor: CustomColor.whiteColor,
                              label: "Dorong ke kanan",
                              style: BaseElevatedButtonStyle.withSuffixIcon,
                              onPressed: () {
                                gameController.setDisplacementDirection(DisplacementDirection.right);
                                gameController.startBlockMovement();
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Form(
                      child: GetBuilder<GameController>(
                        builder: (GameController gameController) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (gameController.gameSceneName.value == "GLB")
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    _buildSimulationInputForm(
                                      title: "Gaya Dorong",
                                      unit: "N",
                                      onChanged: gameController.setAppliedForce,
                                    ),
                                    const Gap(18),
                                    _buildSimulationInputForm(
                                      title: "Durasi Dorong",
                                      unit: "s",
                                      onChanged: gameController.setForceDuration,
                                    ),
                                    const Gap(18),
                                    _buildSimulationInputForm(
                                      title: "Koefisien Gesekan",
                                      unit: "",
                                      onChanged: gameController.setFrictionCoefficient,
                                    ),
                                    const Gap(18),
                                    _buildSimulationInputForm(
                                      title: "Massa Benda",
                                      unit: "kg",
                                      onChanged: gameController.setMass,
                                    ),
                                    const Gap(18),
                                  ],
                                ),
                              if (gameController.gameSceneName.value == "Gaya & Gerak")
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    _buildSimulationInputForm(
                                      title: "Jarak",
                                      unit: "m",
                                      onChanged: gameController.setMovementDistance,
                                    ),
                                    const Gap(18),
                                    _buildSimulationInputForm(
                                      title: "Waktu",
                                      unit: "s",
                                      onChanged: gameController.setMovementTime,
                                    ),
                                    const Gap(18),
                                  ],
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    GetBuilder<GameController>(
                      builder: (GameController gameController) {
                        if (gameController.gameSceneName.value == "Gaya & Gerak") {
                          return Expanded(
                            child: Center(
                              child: GetBuilder<GameController>(
                                builder: (GameController gameController) {
                                  return IconButton.filled(
                                    onPressed: () {
                                      if (gameController.isObjectMoving.value) {
                                        gameController.stopMovement();
                                      } else {
                                        gameController.startMovement();
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll<Color>(CustomColor.lightBlueColor50),
                                    ),
                                    icon: Icon(
                                      gameController.isObjectMoving.value == true
                                          ? Icons.stop_rounded
                                          : Icons.play_arrow_rounded,
                                      size: 65,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSimulationInputForm({
    required String title,
    required String unit,
    required ValueChanged<String> onChanged,
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
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: CustomColor.blackColor.withValues(alpha: 0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    onChanged: onChanged,
                    textInputAction: TextInputAction.next,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
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
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColor.bankRumus,
                          width: 2,
                        ),
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
        ),
      ],
    );
  }
}
