import 'package:cached_network_image/cached_network_image.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/data/responses/simulation/simulation/get_all_simulation.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:fisimate/app/widgets/custom_header.dart';
import 'package:fisimate/app/widgets/custom_search_bar.dart';
import 'package:fisimate/app/widgets/custom_skeleton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../controllers/simulation_controller.dart';
// import 'package:fisimate/app/models/simulation.dart' as simulation_model;

class SimulationView extends GetView<SimulationController> {
  const SimulationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      SimulationController(),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.whiteColor,
      appBar: AppBar(
        backgroundColor: CustomColor.whiteColor,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Simulasi",
          style: headingBold.copyWith(
            color: CustomColor.blueColor,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: CustomSize.marginLarge,
            ),
            color: CustomColor.whiteColor,
            child: Column(
              children: [
                const CustomHeader(),
                const Gap(
                  CustomSize.marginMedium,
                ),
                CustomSearchBar(
                  controller: controller.searchController,
                  onChanged: (String value) =>
                      controller.filterSimulations(value),
                  hint: "Cari",
                  prefix: SvgPicture.asset("assets/icons/search.svg"),
                ),
                const Gap(32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Pembelajaran Terakhir",
                      style: bodyMedium.copyWith(fontSize: 12),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: CustomColor.greyColor,
                      ),
                    )
                  ],
                ),
                const Gap(10),
              ],
            ),
          ),
          GetBuilder<SimulationController>(
            builder: (controller) {
              switch (controller.state) {
                case ResultState.loading:
                  return Expanded(
                    child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return const CustomSkeletonWidget(
                          height: 120,
                        );
                      },
                    ),
                  );
                case ResultState.hasData:
                  return Expanded(
                    child: controller.filteredSimulations.isEmpty
                        ? (controller.searchController.text.isEmpty
                            ? _buildListView(
                                simulations: controller.simulations,
                              )
                            : Center(
                                child: Text(
                                  "Tidak ditemukan simulasi dengan kata kunci ${controller.searchController.text}",
                                ),
                              ))
                        : _buildListView(
                            simulations: controller.filteredSimulations,
                          ),
                  );
                case ResultState.noData:
                  return Center(
                    child: Text(
                      "Tidak ada data",
                      style: bodyRegular.copyWith(
                        color: CustomColor.greyColor,
                      ),
                    ),
                  );
                case ResultState.error:
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Gagal memuat data :(",
                            style: headingBold.copyWith(),
                          ),
                          const Gap(10),
                          FilledButton(
                            onPressed: () {
                              controller.getAllSimulations();
                            },
                            child: const Text("Coba Lagi"),
                          ),
                        ],
                      ),
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  RefreshIndicator _buildListView({
    required List<SimulationDTO> simulations,
  }) {
    return RefreshIndicator(
      color: CustomColor.bankRumus,
      backgroundColor: CustomColor.whiteColor,
      onRefresh: () async {
        controller.getAllSimulations();
      },
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: CustomSize.marginLarge,
        ),
        itemCount: simulations.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              _buildSimulationItem(
                label: simulations[index].title,
                imagePath: simulations[index].icon ?? "",
                simulation: simulations[index],
              ),
              const Gap(10),
            ],
          );
        },
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

  Widget _buildSimulationItem({
    required String label,
    required String imagePath,
    required SimulationDTO simulation,
  }) {
    double currentStep = 0.0;
    double maxStep = 0.0;
    double progress = 0.0;

    if (simulation.simulationProgress!.isNotEmpty) {
      currentStep = simulation.simulationProgress!.first.currentStep.toDouble();
      maxStep = simulation.simulationProgress!.first.totalSteps.toDouble();
    }

    if (simulation.simulationProgress!.isEmpty) {
      currentStep = 0.0;
      maxStep = 0.0;
    }

    if (maxStep != 0.0) {
      progress = currentStep / maxStep;
    } else {
      progress = 0.0;
    }

    return InkWell(
      onTap: () {
        String? gameScene = '';
        if (simulation.title.contains('Gaya & Gerak')) {
          gameScene = 'GLB';
        } else if (simulation.title.contains('Gerak Lurus Beraturan')) {
          gameScene = 'Gaya & Gerak';
        } else
          gameScene = null;

        controller.unfocusSearch();

        Get.toNamed(Routes.SIMULATION_CONTENT, arguments: {
          'simulation': simulation,
          'gameScene': gameScene,
        });
      },
      splashFactory: InkRipple.splashFactory,
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: CustomColor.bankRumus,
          ),
          boxShadow: CustomColor.mainMenuItemShadow,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: imagePath,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
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
                      Expanded(
                        child: Text(
                          label,
                          style: poppinsBold.copyWith(
                            fontSize: 14,
                            color: CustomColor.blackColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Gap(10),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: CustomColor.greyColor,
                        size: 14,
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
                    linearGradient: LinearGradient(colors: [
                      CustomColor.bankRumus,
                      CustomColor.yellowColor,
                    ]),
                    backgroundColor: Colors.grey.shade100,
                    percent: progress,
                    animation: false,
                    barRadius: const Radius.circular(50),
                  ),
                  const Gap(6),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "${currentStep.toInt()} dari ${maxStep.toInt()}",
                      style: bodyRegular.copyWith(
                        color: CustomColor.blueColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
