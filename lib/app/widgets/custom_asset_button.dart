import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:flutter/widgets.dart';

class CustomAssetButton extends StatelessWidget {
  final double? size;
  final String assetPath;
  const CustomAssetButton({
    super.key,
    this.size,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? CustomSize.maxHeight / 18,
      width: size ?? CustomSize.maxHeight / 18,
      decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(16),
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
      child: Center(
        child: Image.asset(
          assetPath,
          height: 27,
          width: 27,
        ),
      ),
    );
  }
}