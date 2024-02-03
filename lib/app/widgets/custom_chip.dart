import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';

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
          border: Border.all(
            color: CustomColor.greenColor,
            width: 2.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 0,
              spreadRadius: 1,
              offset: Offset(0, 0),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 1,
              spreadRadius: -0.5,
              offset: Offset(0, 1),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 3,
              spreadRadius: -1.5,
              offset: Offset(0, 3),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 6,
              spreadRadius: -3,
              offset: Offset(0, 6),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 12,
              spreadRadius: -6,
              offset: Offset(0, 12),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 24,
              spreadRadius: -12,
              offset: Offset(0, 24),
            ),
          ]),
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
            style: bodyRegular.copyWith(color: CustomColor.blackColor),
          ),
        ],
      ),
    );
  }
}
