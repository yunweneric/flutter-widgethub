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
      height: AppSizing.height(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Stop coding from scratch. Build faster. \nLaunch sooner.",
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          AppSizing.kh20Spacer(),
          Text("Free-to-use UI elements designed for rapid development"),
          AppSizing.kh20Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.router.pushNamed("/components/index");
                },
                child: Text("Get started"),
              ),
              AppSizing.kwSpacer(30.w),
              ElevatedButton(
                onPressed: () {
                  context.router.pushNamed("/components/buttons");
                },
                child: Text("Explore"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
