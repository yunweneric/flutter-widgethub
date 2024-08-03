import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:icons_flutter/icons_flutter.dart';

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
              TextButton(
                child: Icon(Icons.menu),
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
              Icon(FontAwesome.moon_o),
              AppSizing.kwSpacer(20.w),
              Icon(AntDesign.search1),
            ],
          )
        ],
      ),
    );
  }
}
