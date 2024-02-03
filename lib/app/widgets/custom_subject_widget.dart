import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomSubjectCard extends StatelessWidget {
  final String assetPath;
  final String title;
  const CustomSubjectCard({
    super.key,
    required this.assetPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CustomSize.maxWidth / 3,
      height: CustomSize.maxWidth / 3,
      decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(20.0),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            width: 80,
          ),
          const Gap(8.0),
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}

class CustomSubjectTitleWidget extends StatelessWidget {
  final String no;
  final String title;
  const CustomSubjectTitleWidget({
    super.key,
    required this.no,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 6.0),
          decoration: BoxDecoration(
              color: CustomColor.orangeColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              )),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: CustomColor.bankMateri,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: Center(
            child: Text(
              no,
              style: subHeadingMedium.copyWith(
                color: CustomColor.whiteColor,
              ),
            ),
          ),
        ),
        const Gap(10.0),
        Text(
          title,
          style: subHeadingSemiBold,
        ),
      ],
    );
  }
}
