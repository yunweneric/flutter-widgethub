import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';

class AppDeviceFrame extends StatefulWidget {
  final DeviceInfo deviceInfo;
  final Widget child;
  final Orientation? orientation;
  final bool? isFrameVisible;

  const AppDeviceFrame({
    super.key,
    required this.deviceInfo,
    required this.child,
    this.orientation = Orientation.portrait,
    this.isFrameVisible = true,
  });

  @override
  State<AppDeviceFrame> createState() => _AppDeviceFrameState();
}

class _AppDeviceFrameState extends State<AppDeviceFrame> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizing.width(context),
      height: AppSizing.isMobile(context) ? AppSizing.height(context) * 0.5 : AppSizing.height(context) * 0.6,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: widget.isFrameVisible == false
            ? Container(child: widget.child)
            : DeviceFrame(
                device: widget.deviceInfo,
                isFrameVisible: widget.isFrameVisible!,
                orientation: widget.orientation!,
                screen: widget.child,
              ),
      ),
    );
  }
}
