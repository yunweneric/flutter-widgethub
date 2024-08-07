import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      height: AppSizing.kHPercentage(context, 90),
      width: AppSizing.kWPercentage(context, 95),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSizing.kHPercentage(context, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Easy to use UI components",
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                AppSizing.kh20Spacer(),
                Text(
                  "Seamlessly integrate a wide range of customizable pre-built UI components to accelerate your development process.",
                ),
                AppSizing.kh20Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
