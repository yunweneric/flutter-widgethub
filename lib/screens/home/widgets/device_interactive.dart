import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/code_highlight.dart';
import 'package:flutterui/shared/ui/widgets/device_section_frame.dart';

class DeviceInteractive extends StatefulWidget {
  const DeviceInteractive({super.key});

  @override
  State<DeviceInteractive> createState() => _DeviceInteractiveState();
}

class _DeviceInteractiveState extends State<DeviceInteractive> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      verticalDirection: VerticalDirection.up,
      runSpacing: 10,
      children: [
        DeviceSectionFrame(
          parentWidth: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 44),
          deviceAlignment: Alignment.bottomCenter,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 0,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.notification_add), label: "Notifications"),
                BottomNavigationBarItem(icon: Icon(Icons.verified_user), label: "Profile"),
              ],
            ),
          ),
        ),
        AppSizing.kwSpacer(AppSizing.kWPercentage(context, 2)),
        SizedBox(
          width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 44),
          height: AppSizing.kHPercentage(context, 35),
          child: CodeHighlight(
            fontSize: 14.sp,
            code: '''DeviceSectionFrame(
          deviceAlignment: Alignment.bottomCenter,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 0,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.notification_add), label: "Notifications"),
                BottomNavigationBarItem(icon: Icon(Icons.verified_user), label: "Profile"),
                // BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
              ],
            ),
          ),
        ),''',
          ),
        )
      ],
    );
  }
}
