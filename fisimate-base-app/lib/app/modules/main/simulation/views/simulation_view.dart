import 'package:cached_network_image/cached_network_image.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:fisimate/app/widgets/custom_header.dart';
import 'package:fisimate/app/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../controllers/simulation_controller.dart';
import 'package:fisimate/app/models/simulation.dart' as simulation_model;

class SimulationView extends GetView<SimulationController> {
  const SimulationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      SimulationController(),
    );
    return Scaffold(
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
                  suffix: SvgPicture.asset("assets/icons/filter.svg"),
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
          Obx(
            () {
              switch (controller.state) {
                case ResultState.loading:
                  return Expanded(
                    child: Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: CustomColor.whiteColor,
                              borderRadius: BorderRadius.circular(
                                CustomSize.roundedMedium,
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Text("Loading..."),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                case ResultState.hasData:
                  return Expanded(
                    child: controller.filteredSimulations.isEmpty
                        ? _buildListView(
                            simulations: controller.simulations,
                          )
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
                  return Center(
                    child: Text(
                      "Terjadi kesalahan",
                      style: bodyRegular.copyWith(
                        color: CustomColor.greyColor,
                      ),
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }

  ListView _buildListView({
    required List<simulation_model.Simulation> simulations,
  }) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: CustomSize.marginLarge,
      ),
      itemCount: simulations.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            _buildSimulationItem(
              label: simulations[index].title ?? "",
              imagePath: simulations[index].icon ?? "",
              progress: 100,
              simulation: simulations[index],
            ),
            const Gap(10),
          ],
        );
      },
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
    required int progress,
    required String imagePath,
    required simulation_model.Simulation simulation,
  }) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.SIMULATION_CONTENT, arguments: simulation);
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
              child: CachedNetworkImage(
                imageUrl: imagePath,
                imageBuilder: (context, imageProvider) => Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                          "Simulasi $label",
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
      ),
    );
  }
}
