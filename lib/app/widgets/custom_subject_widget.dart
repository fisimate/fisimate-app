import 'package:cached_network_image/cached_network_image.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomSubjectCard extends StatelessWidget {
  final String assetPath;
  final String title;
  final Function()? onTap;
  final Color? splashColor;

  const CustomSubjectCard({
    super.key,
    required this.assetPath,
    required this.title,
    this.onTap,
    this.splashColor = const Color(0xffF4BB00),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0),
      splashFactory: InkRipple.splashFactory,
      splashColor: splashColor,
      child: Ink(
        width: CustomSize.maxWidth / 3,
        height: CustomSize.maxWidth / 3,
        decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: CustomColor.customBoxShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: assetPath,
              width: 80,
            ),
            const Gap(8.0),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CustomSize.marginMedium,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
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
