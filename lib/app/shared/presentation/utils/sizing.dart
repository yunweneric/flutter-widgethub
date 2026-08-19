/// Sizing and layout utilities.
///
/// Provides helper methods for responsive sizing, device detection,
/// and common layout calculations using ScreenUtil for responsive design.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/utils/colors.dart';

/// Utility class for sizing and responsive design calculations.
///
/// Provides methods for getting screen dimensions, calculating percentages,
/// creating borders, and detecting device types.
class AppSizing {
  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;
  static double height(BuildContext context) =>
      MediaQuery.sizeOf(context).height;
  static double kHPercentage(BuildContext context, double value) =>
      (height(context) * value) / 100;
  static double kWPercentage(BuildContext context, double value) =>
      (width(context) * value) / 100;
  static BorderRadius radiusMd() => AppRadii.mdAll;
  static BorderRadius radiusSm() => AppRadii.smAll;
  static BorderRadius radiusLg() => AppRadii.lgAll;

  static OutlineInputBorder mainBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: AppRadii.mdAll,
    );
  }

  static OutlineInputBorder mainFocusBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 1.5, color: AppColors.primary),
      borderRadius: AppRadii.mdAll,
    );
  }

  static OutlineInputBorder focusedErrorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 1.5, color: AppColors.red),
      borderRadius: AppRadii.mdAll,
    );
  }

  static OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.red),
      borderRadius: AppRadii.mdAll,
    );
  }

  static EdgeInsets kMainPadding(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: isMobile(context) ? 15.w : 30.w);

  static EdgeInsets kPadding(double width, double height) =>
      EdgeInsets.symmetric(horizontal: width.w, vertical: height.h);

  // Deprecated: Use Kh20Spacer widget instead
  @Deprecated('Use Kh20Spacer widget instead')
  static Widget kh20Spacer() => const Kh20Spacer();

  // Deprecated: Use Kh10Spacer widget instead
  @Deprecated('Use Kh10Spacer widget instead')
  static Widget kh10Spacer() => const Kh10Spacer();

  // Deprecated: Use KhSpacer widget instead
  @Deprecated('Use KhSpacer widget instead')
  static Widget khSpacer(double height) => KhSpacer(height: height);

  // Deprecated: Use KwSpacer widget instead
  @Deprecated('Use KwSpacer widget instead')
  static Widget kwSpacer(double width) => KwSpacer(width: width);

  static bool isXMobile(BuildContext context) => width(context) < 380;
  static bool isMobile(BuildContext context) => width(context) < 789;
  static bool isTablet(BuildContext context) =>
      width(context) > 789 && width(context) < 992;
  static bool isDesktop(BuildContext context) => width(context) > 992;
}

class Kh20Spacer extends StatelessWidget {
  const Kh20Spacer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 20.h);
  }
}

class Kh10Spacer extends StatelessWidget {
  const Kh10Spacer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 10.h);
  }
}

class KhSpacer extends StatelessWidget {
  final double height;

  const KhSpacer({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class KwSpacer extends StatelessWidget {
  final double width;

  const KwSpacer({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
