import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../theme/colors.dart';
import '../theme/fonts.dart';
import '../theme/sizing.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.yellowColor,
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
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Eksplorasi\nInteraktif',
                      style: poppinsSemiBold.copyWith(
                        fontSize: 23,
                        color: CustomColor.blackColor,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      'Sentuh, putar, dan amati setiap percobaan untuk mendapatkan pemahaman yang mendalam.',
                      style: poppinsRegular.copyWith(
                        fontSize: 12,
                        color: CustomColor.blackColor,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/header.png",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
