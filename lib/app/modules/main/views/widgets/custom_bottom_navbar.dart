import 'package:fisimate/app/modules/main/controllers/main_controller.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          _buildNavbarItem(
            assetPath: "assets/icons/home.svg",
            label: "Beranda",
            index: 0,
          ),
          _buildNavbarItem(
            assetPath: "assets/icons/experiment.svg",
            label: "Simulasi",
            index: 1,
          ),
          _buildNavbarItem(
            assetPath: "assets/icons/chatbot.svg",
            label: "ChatBot",
            index: 2,
          ),
          _buildNavbarItem(
            assetPath: "assets/icons/profile.svg",
            label: "Profil",
            index: 3,
          ),
        ],
      ),
    );
  }

  Expanded _buildNavbarItem({
    required String assetPath,
    required String label,
    required int index,
  }) {
    return Expanded(
      child: InkResponse(
        onTap: () {
          MainController controller = Get.find<MainController>();
          controller.changePage(index);
        },
        splashFactory: InkRipple.splashFactory,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              assetPath,
              height: 25,
            ),
            const Gap(
              10,
            ),
            Text(
              label,
              style: poppinsMedium.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
