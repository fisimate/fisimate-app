import 'package:fisimate/app/modules/main/simulation/controllers/simulation_controller.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.hint,
    this.onClick,
    this.withElevation,
    this.readOnly = false,
    this.onChanged,
    this.suffix,
    this.prefix,
    this.controller,
  });

  final String hint;
  final Function? onClick;
  final bool? withElevation;
  final bool readOnly;
  final Widget? suffix;
  final Widget? prefix;
  final Function(String)? onChanged;
  final TextEditingController? controller;

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
          side: BorderSide.none,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: CustomColor.mainMenuItemShadow,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            focusNode: Get.find<SimulationController>().searchFocusNode,
            cursorColor: CustomColor.blueColor,
            enabled: widget.onClick == null,
            readOnly: widget.readOnly,
            onChanged: (data) {
              widget.onChanged?.call(data);
              setState(
                () {
                  showClearButton = controller.text.isNotEmpty;
                },
              );
            },
            controller: controller,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: bodyRegular.copyWith(fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              filled: true,
              fillColor: CustomColor.searchBarGreyColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 50,
              ),
              suffixIcon: widget.suffix,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 50,
              ),
              prefixIcon: widget.prefix,
            ),
          ),
        ),
      ),
    );
  }
}
