import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    Key? key,
    required this.hint,
    this.onClick,
    this.withElevation,
    this.readOnly = false,
    this.onChanged,
    this.suffix,
    this.prefix,
  }) : super(key: key);
  final String hint;
  final Function? onClick;
  final bool? withElevation;
  final bool readOnly;
  final Icon? suffix;
  final Icon? prefix;
  final Function(String)? onChanged;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final controller = TextEditingController();
  bool? showClearButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onClick?.call(),
      child: Material(
        color: Colors.white,
        elevation: widget.withElevation == true ? 1 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: Colors.grey,
          ),
        ),
        child: TextField(
          cursorColor: CustomColor.blueColor,
          enabled: widget.onClick == null,
          readOnly: widget.readOnly,
          onChanged: (data) {
            widget.onChanged?.call(data);
            setState(() {
              showClearButton = controller.text.isNotEmpty;
            });
          },
          controller: controller,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: bodyRegular.copyWith(fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: CustomColor.greyColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: CustomColor.blackColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            suffixIcon: widget.suffix,
            prefixIcon: widget.prefix,
          ),
        ),
      ),
    );
  }
}
