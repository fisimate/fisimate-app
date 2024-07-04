import 'package:fisimate_flutter_app/app/theme/colors.dart';
import 'package:fisimate_flutter_app/app/theme/fonts.dart';
import 'package:fisimate_flutter_app/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomLeaderboardTile extends StatelessWidget {
  final int position;
  final String name;
  final String imageUrl;
  final int score;
  const CustomLeaderboardTile({
    super.key,
    required this.position,
    required this.name,
    required this.imageUrl,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CustomSize.maxWidth,
      height: CustomSize.maxHeight / 12,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        boxShadow: CustomColor.customBoxShadow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            '$position',
            style: subHeadingBold.copyWith(
              color: CustomColor.blueColor,
              fontSize: 16,
            ),
          ),
          const Gap(20.0),
          Container(
            width: CustomSize.maxHeight / 12 - 16,
            height: CustomSize.maxHeight / 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(20.0),
          Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: subHeadingMedium.copyWith(
              color: CustomColor.blackColor,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Image.asset(
            'assets/icons/regular-medal.png',
            width: 20,
          ),
          const Gap(8.0),
          Text(
            '$score',
            style: poppinsRegular.copyWith(
              color: CustomColor.blackColor,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
