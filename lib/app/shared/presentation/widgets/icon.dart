import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  final String icon;
  final double? size;
  final Color? color;
  const AppIcon({super.key, required this.icon, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      width: size ?? 20.w,
      height: size ?? 20.w,
      color: color ?? Theme.of(context).highlightColor,
      placeholderBuilder: (context) {
        return Center(
          child: SizedBox(
            width: 10.w,
            height: 10.w,
            child: CircularProgressIndicator(strokeWidth: 1.w),
          ),
        );
      },
    );
  }
}
