import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';

class IconDropdownButton<T> extends StatelessWidget {
  final Widget button;
  final Widget Function(T) builder;
  final T? item;
  final double? btnWidthFraction;
  final Offset? dropDownOffset;

  final List<T> items;
  final Function(T?)? onChanged;
  const IconDropdownButton({
    super.key,
    required this.button,
    required this.builder,
    required this.items,
    this.item,
    this.onChanged,
    this.btnWidthFraction,
    this.dropDownOffset,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<T>(
      customButton: button,
      onChanged: onChanged,
      isExpanded: true,
      items: items.map((item) => DropdownMenuItem<T>(value: item, child: builder.call(item))).toList(),
      dropdownStyleData: DropdownStyleData(
        elevation: 1,
        width: btnWidthFraction,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
        ),
        offset: dropDownOffset ??
            Offset(
              btnWidthFraction != null ? btnWidthFraction! / -3 : 120.w,
              -8,
            ),
      ),
      menuItemStyleData: MenuItemStyleData(height: 30.h),
    );
  }
}
