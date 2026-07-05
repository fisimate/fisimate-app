import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    super.key,
    this.height = kMinInteractiveDimension + 5,
    this.width,
    this.onTap,
    this.child,
  });

  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final Widget? child;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.black12),
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: widget.child ?? const SizedBox(),
          ),
        ),
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    this.width,
    this.onItemSelected,
    this.dropdownItems,
  });

  final double? width;
  final ValueChanged<String>? onItemSelected;
  final List<String>? dropdownItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200,
      height: 300,
      decoration: ShapeDecoration(
        color: CustomColor.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Colors.black12,
          ),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 32,
            offset: Offset(0, 20),
            spreadRadius: -8,
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: dropdownItems?.length ?? 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ElevatedButton(
            onPressed: () {
              onItemSelected?.call(dropdownItems![index]);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor.whiteColor,
              foregroundColor: CustomColor.blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              dropdownItems![index],
              style: poppinsMedium.copyWith(
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    this.dropdownItems,
    this.onItemSelected,
  });

  final List<String>? dropdownItems;
  final ValueChanged<String>? onItemSelected;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String _selectedItem = 'Mau latihan soal bab apa?';
  String get selectedItem => _selectedItem;

  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _link = LayerLink();
  double? _buttonWidth;

  void onItemSelected(String item) {
    setState(() {
      _selectedItem = item;
    });
    widget.onItemSelected?.call(item);
    _tooltipController.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _tooltipController,
        overlayChildBuilder: (BuildContext context) {
          return CompositedTransformFollower(
            link: _link,
            targetAnchor: Alignment.topLeft,
            offset: const Offset(0, -310),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: MenuWidget(
                width: _buttonWidth,
                onItemSelected: onItemSelected,
                dropdownItems: widget.dropdownItems,
              ),
            ),
          );
        },
        child: ButtonWidget(
          onTap: onTap,
          child: Text(
            _selectedItem,
            style: subHeadingRegular,
          ),
        ),
      ),
    );
  }

  void onTap() {
    _buttonWidth = context.size?.width;
    _tooltipController.toggle();
  }
}
