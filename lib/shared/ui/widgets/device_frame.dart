import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDeviceFrame extends StatefulWidget {
  final DeviceInfo deviceInfo;
  final Widget child;
  const AppDeviceFrame({super.key, required this.deviceInfo, required this.child});

  @override
  State<AppDeviceFrame> createState() => _AppDeviceFrameState();
}

class _AppDeviceFrameState extends State<AppDeviceFrame> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DeviceFrame(
        device: widget.deviceInfo,
        isFrameVisible: true,
        orientation: Orientation.portrait,
        screen: widget.child,
      ),
    );
  }
}
