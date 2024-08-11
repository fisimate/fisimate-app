import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TopLeaderboardCard extends StatelessWidget {
  final int position;
  final String name;
  final String? imageUrl;

  const TopLeaderboardCard({
    super.key,
    required this.position,
    required this.name,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    String iconPath = 'assets/icons/gold-medal.png';
    if (position == 2) {
      iconPath = 'assets/icons/silver-medal.png';
    } else if (position == 3) {
      iconPath = 'assets/icons/bronze-medal.png';
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: CustomSize.maxWidth / 2.6,
          height: CustomSize.maxWidth / 2.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: CustomColor.whiteColor,
              width: 4,
            ),
            boxShadow: CustomColor.customBoxShadow,
            image: DecorationImage(
              image: imageUrl != ''
                  ? NetworkImage(imageUrl!)
                  : const AssetImage(
                      'assets/images/default/default_profile_photo.png',
                    ) as ImageProvider,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
        Positioned(
          bottom: -60,
          width: CustomSize.maxWidth / 2.6,
          child: Column(
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(iconPath),
                  ),
                ),
              ),
              const Gap(8.0),
              Text(
                name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: poppinsMedium.copyWith(
                  color: CustomColor.blackColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
