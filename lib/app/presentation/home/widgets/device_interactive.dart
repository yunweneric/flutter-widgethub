import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/utils/colors.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/code_highlight.dart';
import 'package:flutterui/app/shared/presentation/widgets/device_section_frame.dart';

class DeviceInteractive extends StatefulWidget {
  const DeviceInteractive({super.key});

  @override
  State<DeviceInteractive> createState() => _DeviceInteractiveState();
}

class _DeviceInteractiveState extends State<DeviceInteractive> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      verticalDirection: VerticalDirection.up,
      runSpacing: 10,
      children: [
        StatefulBuilder(
          builder: (context,state) {
            return DeviceSectionFrame(
              parentWidth: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 44),
              parentHeight: AppSizing.kHPercentage(context, AppSizing.isDesktop(context) ? 60 : 40),
              deviceAlignment: Alignment.bottomCenter,
              child: Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: AnimatedContainer(
                  height: AppSizing.height(context),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: currentIndex == 0
                        ? Colors.red.withOpacity(0.8)
                        : currentIndex == 1
                            ? Colors.teal.withOpacity(0.8)
                            : Colors.blue.withOpacity(0.8),
                  ),
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TweenAnimationBuilder(
                        key: ValueKey(currentIndex),
                        tween: Tween<double>(begin: 1, end: 0),
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.bounceOut,
                        builder: (context, value, child) {
                          return Transform(
                            transform: Matrix4.identity()..translate(0.0, -value * 200),
                            child: Text(
                              currentIndex == 0
                                  ? "RED"
                                  : currentIndex == 1
                                      ? "TEAL"
                                      : "BLUE",
                              style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w900, color: AppColors.TEXTWHITE),
                            ),
                          );
                        },
                      ),
                      AppSizing.khSpacer(AppSizing.kHPercentage(context, 6)),
                    ],
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  selectedItemColor: currentIndex == 0
                      ? Colors.red.withOpacity(1)
                      : currentIndex == 1
                          ? Colors.teal.withOpacity(1)
                          : Colors.blue.withOpacity(1),
                  onTap: (index) => {
                    state(() {
                      currentIndex = index;
                    })
                  },
                  currentIndex: currentIndex,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Red"),
                    BottomNavigationBarItem(icon: Icon(Icons.notification_add), label: "Teal"),
                    BottomNavigationBarItem(icon: Icon(Icons.verified_user), label: "Blue"),
                  ],
                ),
              ),
            );
          }
        ),
        AppSizing.kwSpacer(AppSizing.kWPercentage(context, 2)),
        SizedBox(
          width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 44),
          height: AppSizing.kHPercentage(context, AppSizing.isDesktop(context) ? 60 : 40),
          child: CodeHighlight(fontSize: AppSizing.isMobile(context) ? 10 : 14, code: code),
        )
      ],
    );
  }
}

const code = '''import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/components/ui/export/data.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/code_highlight.dart';
import 'package:flutterui/shared/ui/widgets/device_section_frame.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';

class DeviceInteractive extends StatefulWidget {
  const DeviceInteractive({super.key});

  @override
  State<DeviceInteractive> createState() => _DeviceInteractiveState();
}

class _DeviceInteractiveState extends State<DeviceInteractive> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        verticalDirection: VerticalDirection.up,
        runSpacing: 10,
        children: [
          DeviceSectionFrame(
            parentWidth: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 44),
            parentHeight: AppSizing.kHPercentage(context, 60),
            deviceAlignment: Alignment.bottomCenter,
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: AnimatedContainer(
                height: AppSizing.height(context),
                width: AppSizing.width(context),
                // alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: currentIndex == 0
                      ? Colors.red.withOpacity(0.5)
                      : currentIndex == 1
                          ? Colors.teal.withOpacity(0.5)
                          : Colors.blue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                duration: const Duration(milliseconds: 800),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TweenAnimationBuilder(
                      key: ValueKey(currentIndex),
                      tween: Tween<double>(begin: 1, end: 0),
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.bounceOut,
                      builder: (context, value, child) {
                        return Transform(
                          transform: Matrix4.identity()..translate(0.0, -value * 200),
                          child: Text(
                            currentIndex == 0
                                ? "RED"
                                : currentIndex == 1
                                    ? "TEAL"
                                    : "BLUE",
                            style: TextStyle(fontSize: 80, fontWeight: FontWeight.w900),
                          ),
                        );
                      },
                    ),
                    AppSizing.khSpacer(AppSizing.kHPercentage(context, 6)),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                    // border: Border(top: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.5))),
                    ),
                child: BottomNavigationBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  onTap: (index) => {
                    setState(() {
                      currentIndex = index;
                    })
                  },
                  currentIndex: currentIndex,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Red"),
                    BottomNavigationBarItem(icon: Icon(Icons.notification_add), label: "Teal"),
                    BottomNavigationBarItem(icon: Icon(Icons.verified_user), label: "Blue"),
                  ],
                ),
              ),
            ),
          ),
          AppSizing.kwSpacer(AppSizing.kWPercentage(context, 2)),
          SizedBox(
            width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 44),
            height: AppSizing.kHPercentage(context, 60),
            child: CodeHighlight(
              fontSize: 14.sp,
              code: AllComponents.widgets.first.code,
            ),
          )
        ],
      ),
    );
  }
}
''';
