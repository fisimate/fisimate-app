import 'package:fisimate_flutter_app/app/theme/colors.dart';
import 'package:fisimate_flutter_app/app/theme/fonts.dart';
import 'package:fisimate_flutter_app/app/theme/sizing.dart';
import 'package:flutter/widgets.dart';

class CustomFilledButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Color? color;
  final double? radius;
  final void Function()? onTap;
  const CustomFilledButton({
    super.key,
    this.width,
    this.height,
    this.radius,
    this.color = const Color(0xff072DF4),
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? CustomSize.maxWidth,
        height: height ?? CustomSize.maxHeight / 18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 75.0),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: headingBold.copyWith(
              color: CustomColor.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
