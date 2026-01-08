import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/shared/presentation/utils/colors.dart';

class AppSizing {
  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;
  static double height(BuildContext context) => MediaQuery.sizeOf(context).height;
  static double kHPercentage(BuildContext context, double value) => (height(context) * value) / 100;
  static double kWPercentage(BuildContext context, double value) => (width(context) * value) / 100;
  static radiusMd() => BorderRadius.circular(10.r);
  static radiusSm() => BorderRadius.circular(5.r);

  static OutlineInputBorder mainBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: color),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    );
  }

  static OutlineInputBorder mainFocusBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 0.6, color: AppColors.PRIMARY),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    );
  }

  static OutlineInputBorder focusedErrorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: AppColors.RED),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    );
  }

  static OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 0.6, color: AppColors.RED),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    );
  }

  static EdgeInsets kMainPadding(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: isMobile(context) ? 15.w : 30.w);

  static EdgeInsets kpadding(double width, double height) =>
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

  static bool isXMobile(context) => width(context) < 380;
  static bool isMobile(context) => width(context) < 789;
  static bool isTablet(context) => width(context) > 789 && width(context) < 992;
  static bool isDesktop(context) => width(context) > 992;
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
