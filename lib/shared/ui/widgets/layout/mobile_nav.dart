import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';

class MobileNav extends StatefulWidget {
  const MobileNav({super.key});

  @override
  State<MobileNav> createState() => _MobileNavState();
}

class _MobileNavState extends State<MobileNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 20.h,
      padding: AppSizing.kMainPadding() + EdgeInsets.symmetric(vertical: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ElevatedButton(
                child: AppIcon(icon: AppIcons.menu),
                onPressed: () {},
              ),
              TextButton(
                child: Text("Logo", style: Theme.of(context).textTheme.displayMedium),
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              TextButton(onPressed: () {}, child: AppIcon(icon: AppIcons.moon)),
              TextButton(onPressed: () {}, child: AppIcon(icon: AppIcons.search)),
            ],
          )
        ],
      ),
    );
  }
}
