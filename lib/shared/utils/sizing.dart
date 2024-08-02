import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/utils/colors.dart';

class AppSizing {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  static OutlineInputBorder mainBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: color),
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
    );
  }

  static OutlineInputBorder mainFocusBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: AppColors.DARKRED),
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
    );
  }

  static OutlineInputBorder focusedErrorBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.RED),
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
    );
  }

  static OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: AppColors.RED),
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
    );
  }

  SizedBox minorInputSpacer(BuildContext context) => SizedBox(height: 5.h);

  SizedBox inputSpacer(BuildContext context) => SizedBox(height: height(context) / 50);

  SizedBox minorSpacer(BuildContext context) => SizedBox(height: height(context) / 30);

  SizedBox majorSpacer(BuildContext context) => SizedBox(height: height(context) / 10);

  EdgeInsets kMainPadding() => EdgeInsets.symmetric(horizontal: 20.w);

  EdgeInsets kpadding(double width, double height) => EdgeInsets.symmetric(horizontal: width.w, vertical: height.h);

  Widget kh20Spacer() => SizedBox(height: 20.h);
  Widget kh10Spacer() => SizedBox(height: 10.h);

  Widget khSpacer(double height) => SizedBox(height: height);

  Widget kwSpacer(double width) => SizedBox(width: width);
}
