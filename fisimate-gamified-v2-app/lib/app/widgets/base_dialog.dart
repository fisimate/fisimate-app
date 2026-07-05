import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    super.key,
    required this.text,
    required this.onConfirm,
    required this.onCancel,
  });

  final String text;
  final Function() onConfirm;
  final Function() onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 34),
      backgroundColor: CustomColor.whiteColor,
      surfaceTintColor: CustomColor.transparentColor,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              text,
              style: subHeadingRegular,
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: CustomColor.errorColor,
                      backgroundColor: CustomColor.whiteColor,
                      elevation: 0,
                      side: BorderSide(
                        color: CustomColor.errorColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      'Tidak',
                      style: subHeadingBold,
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: CustomColor.whiteColor,
                      backgroundColor: CustomColor.greenColor,
                      elevation: 0,
                      side: BorderSide(
                        color: CustomColor.greenColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      'Ya',
                      style: subHeadingBold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
