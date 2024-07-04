import 'package:fisimate_flutter_app/app/theme/colors.dart';
import 'package:fisimate_flutter_app/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomSimulationNavigator extends StatelessWidget {
  final bool? isOnResultPage;
  final int currentSectionIndex;
  final Function() onNextPressed;
  final Function() onBackPressed;

  const CustomSimulationNavigator({
    super.key,
    this.isOnResultPage,
    required this.currentSectionIndex,
    required this.onNextPressed,
    required this.onBackPressed,
  });

  const CustomSimulationNavigator.onResultPage({
    super.key,
    required this.currentSectionIndex,
    required this.onNextPressed,
    required this.onBackPressed,
  }) : isOnResultPage = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: currentSectionIndex == 0 && isOnResultPage == false
          ? MainAxisAlignment.end
          : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (currentSectionIndex != 0 || isOnResultPage == null)
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: CustomSize.marginLarge,
            ),
            child: BaseElevatedButton.icon(
              iconData: Icons.arrow_back,
              onPressed: onBackPressed,
              backgroundColor: CustomColor.whiteColor,
              foregroundColor: CustomColor.blueColor,
              label: "Kembali",
              style: BaseElevatedButtonStyle.withPrefixIcon,
            ),
          ),
        if (isOnResultPage == true)
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: 20,
                bottom: CustomSize.marginLarge,
              ),
              child: BaseElevatedButton(
                onPressed: onBackPressed,
                backgroundColor: CustomColor.whiteColor,
                foregroundColor: CustomColor.blueColor,
                label: "Beranda",
                style: BaseElevatedButtonStyle.withPrefixIcon,
              ),
            ),
          ),
        if (currentSectionIndex != 0 || isOnResultPage == null)
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: CustomSize.marginLarge,
            ),
            child: BaseElevatedButton.icon(
              iconData: Icons.arrow_forward,
              onPressed: onNextPressed,
              backgroundColor: CustomColor.blueColor,
              foregroundColor: CustomColor.whiteColor,
              label: "Pembahasan",
              style: BaseElevatedButtonStyle.withSuffixIcon,
            ),
          ),
        if (isOnResultPage == true) const Gap(20),
        if (isOnResultPage == true)
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                right: 20,
                bottom: CustomSize.marginLarge,
              ),
              child: BaseElevatedButton(
                onPressed: onNextPressed,
                backgroundColor: CustomColor.blueColor,
                foregroundColor: CustomColor.whiteColor,
                label: "Pembahasan",
                style: BaseElevatedButtonStyle.withSuffixIcon,
              ),
            ),
          ),
      ],
    );
  }
}

enum BaseElevatedButtonStyle { withPrefixIcon, withSuffixIcon }

class BaseElevatedButton extends StatelessWidget {
  const BaseElevatedButton({
    super.key,
    this.iconData,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.label,
    required this.style,
  });

  const BaseElevatedButton.icon({
    super.key,
    required this.iconData,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.label,
    required this.style,
  });

  final IconData? iconData;
  final Function() onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final String label;
  final BaseElevatedButtonStyle style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 0,
        minimumSize: const Size(0, 50),
        padding: const EdgeInsets.symmetric(
          horizontal: CustomSize.marginMedium,
          vertical: CustomSize.marginSmall,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        side: BorderSide(
          color: CustomColor.blueColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconData != null &&
              style == BaseElevatedButtonStyle.withPrefixIcon)
            Icon(
              iconData,
            ),
          if (iconData != null &&
              style == BaseElevatedButtonStyle.withPrefixIcon)
            const Gap(10),
          Text(
            label,
          ),
          if (iconData != null &&
              style == BaseElevatedButtonStyle.withSuffixIcon)
            const Gap(10),
          if (iconData != null &&
              style == BaseElevatedButtonStyle.withSuffixIcon)
            Icon(
              iconData,
            ),
        ],
      ),
    );
  }
}
