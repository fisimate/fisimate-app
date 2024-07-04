import 'package:fisimate_flutter_app/app/theme/colors.dart';
import 'package:fisimate_flutter_app/app/theme/sizing.dart';
import 'package:flutter/widgets.dart';

class CustomAssetButton extends StatelessWidget {
  final double? size;
  final String assetPath;
  final void Function()? onTap;
  const CustomAssetButton({
    super.key,
    this.size,
    required this.assetPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size ?? CustomSize.maxHeight / 18,
        width: size ?? CustomSize.maxHeight / 18,
        decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: CustomColor.customBoxShadow,
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            height: 27,
            width: 27,
          ),
        ),
      ),
    );
  }
}
