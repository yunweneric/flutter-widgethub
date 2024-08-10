import 'package:flutter/material.dart';
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
            parentHeight: AppSizing.kHPercentage(context, 50),
            deviceAlignment: Alignment.bottomCenter,
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: AnimatedContainer(
                height: AppSizing.height(context),
                width: AppSizing.width(context),
                // alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: currentIndex == 0
                      ? Colors.teal.withOpacity(0.2)
                      : currentIndex == 1
                          ? Colors.red.withOpacity(0.2)
                          : Colors.yellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                duration: Duration(milliseconds: 800),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TweenAnimationBuilder(
                      key: ValueKey(currentIndex),
                      tween: Tween<double>(begin: 1, end: 0),
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.bounceOut,
                      builder: (context, value, child) {
                        return Transform(
                          transform: Matrix4.identity()..translate(0.0, -value * 100),
                          child: AppIcon(icon: AppIcons.clipboard),
                        );
                      },
                    ),
                    AppSizing.khSpacer(AppSizing.kHPercentage(context, 8)),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
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
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Flutter"),
                    BottomNavigationBarItem(icon: Icon(Icons.notification_add), label: "Dart"),
                    BottomNavigationBarItem(icon: Icon(Icons.verified_user), label: "Vs Code"),
                  ],
                ),
              ),
            ),
          ),
          AppSizing.kwSpacer(AppSizing.kWPercentage(context, 2)),
          SizedBox(
            width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 44),
            height: AppSizing.kHPercentage(context, 50),
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
