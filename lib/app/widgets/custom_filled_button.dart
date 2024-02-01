import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:flutter/widgets.dart';

class CustomFilledButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  const CustomFilledButton({
    super.key,
    this.width,
    this.height,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? CustomSize.maxWidth,
      height: height ?? CustomSize.maxHeight / 13.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(75.0),
        color: CustomColor.blueColor,
      ),
      child: Center(
        child: Text(
          text,
          style: headingBold.copyWith(
            color: CustomColor.whiteColor,
          ),
        ),
      ),
    );
  }
}
