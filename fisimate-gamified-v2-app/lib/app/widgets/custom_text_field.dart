import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.height,
    this.width,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? CustomSize.maxWidth,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: CustomColor.customBoxShadow,
      ),
      child: TextFormField(
        style: subHeadingRegular.copyWith(
          color: const Color(0xff999999),
        ),
        focusNode: focusNode,
        obscureText: obscureText,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          fillColor: const Color(0xffEFEFF0),
          filled: true,
          hintText: hintText,
          errorStyle: subHeadingRegular.copyWith(
            color: CustomColor.errorColor,
          ),
          hintStyle: subHeadingRegular.copyWith(
            color: const Color(0xff999999),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide.none,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
