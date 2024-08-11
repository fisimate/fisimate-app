import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
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
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      margin: const EdgeInsets.only(
        left: 10,
        bottom: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: CustomColor.greyColor.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
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
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: imageUrl.isNotEmpty
                    ? NetworkImage(
                        imageUrl,
                      )
                    : const AssetImage(
                        'assets/images/dummy_profile_photo.png',
                      ) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(20.0),
          Expanded(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: subHeadingMedium.copyWith(
                color: CustomColor.blackColor,
                fontSize: 14,
              ),
            ),
          ),
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
