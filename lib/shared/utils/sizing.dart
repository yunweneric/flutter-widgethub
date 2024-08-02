import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/utils/colors.dart';

class AppSizing {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static radiusMd() => BorderRadius.circular(10.r);
  static radiusSm() => BorderRadius.circular(5.r);
  static OutlineInputBorder mainBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: color),
      borderRadius: BorderRadius.all(Radius.circular(45.r)),
    );
  }

  static OutlineInputBorder mainFocusBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: AppColors.DARKRED),
      borderRadius: BorderRadius.all(Radius.circular(45.r)),
    );
  }

  static OutlineInputBorder focusedErrorBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.RED),
      borderRadius: BorderRadius.all(Radius.circular(45.r)),
    );
  }

  static OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: AppColors.RED),
      borderRadius: BorderRadius.all(Radius.circular(45.r)),
    );
  }

  static SizedBox minorInputSpacer(BuildContext context) => SizedBox(height: 5.h);

  static SizedBox inputSpacer(BuildContext context) => SizedBox(height: height(context) / 50);

  static SizedBox minorSpacer(BuildContext context) => SizedBox(height: height(context) / 30);

  static SizedBox majorSpacer(BuildContext context) => SizedBox(height: height(context) / 10);

  static EdgeInsets kMainPadding() => EdgeInsets.symmetric(horizontal: 20.w);

  static EdgeInsets kpadding(double width, double height) => EdgeInsets.symmetric(horizontal: width.w, vertical: height.h);

  static Widget kh20Spacer() => SizedBox(height: 20.h);
  static Widget kh10Spacer() => SizedBox(height: 10.h);

  static Widget khSpacer(double height) => SizedBox(height: height);

  static Widget kwSpacer(double width) => SizedBox(width: width);
}
