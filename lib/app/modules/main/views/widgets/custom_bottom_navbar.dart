import 'package:fisimate/app/modules/main/controllers/main_controller.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      color: CustomColor.whiteColor,
      child: Row(
        children: <Widget>[
          _buildNavbarItem(
            activeIconPath: "assets/icons/home_active.svg",
            inActiveIconPath: "assets/icons/home_inactive.svg",
            label: "Beranda",
            index: 0,
          ),
          _buildNavbarItem(
            activeIconPath: "assets/icons/experiment_active.svg",
            inActiveIconPath: "assets/icons/experiment_inactive.svg",
            label: "Simulasi",
            index: 1,
          ),
          _buildNavbarItem(
            activeIconPath: "assets/icons/chatbot_active.svg",
            inActiveIconPath: "assets/icons/chatbot_inactive.svg",
            label: "ChatBot",
            index: 2,
          ),
          _buildNavbarItem(
            activeIconPath: "assets/icons/profile_active.svg",
            inActiveIconPath: "assets/icons/profile_inactive.svg",
            label: "Profil",
            index: 3,
          ),
        ],
      ),
    );
  }

  Expanded _buildNavbarItem({
    required String activeIconPath,
    required String inActiveIconPath,
    required String label,
    required int index,
  }) {
    MainController controller = Get.find<MainController>();
    return Expanded(
      child: InkResponse(
        onTap: () {
          controller.changePage(index);
        },
        splashFactory: InkRipple.splashFactory,
        child: Ink(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Obx(
                () => SvgPicture.asset(
                  controller.currentIndex.value == index
                      ? activeIconPath
                      : inActiveIconPath,
                  height: 25,
                ),
              ),
              const Gap(
                10,
              ),
              Obx(
                () => Text(
                  label,
                  style: poppinsMedium.copyWith(
                    fontSize: 12,
                    color: controller.currentIndex.value == index
                        ? CustomColor.activeColor
                        : CustomColor.inActiveColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
