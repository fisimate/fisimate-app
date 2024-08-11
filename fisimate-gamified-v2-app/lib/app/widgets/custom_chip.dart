import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class CustomChip extends StatelessWidget {
  final String label;
  const CustomChip({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.circular(16.0),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              CustomColor.greenColor,
              CustomColor.yellowColor,
            ],
          ),
          width: 3,
        ),
        boxShadow: CustomColor.customBoxShadow,
      ),
      child: Wrap(
        spacing: 6.0,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            Icons.check_rounded,
            size: 16,
            color: CustomColor.greenColor,
          ),
          Text(
            label,
            style: bodyRegular.copyWith(
              color: CustomColor.blackColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
