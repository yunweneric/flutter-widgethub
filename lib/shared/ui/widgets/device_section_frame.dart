import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/device_frame.dart';

class DeviceSectionFrame extends StatefulWidget {
  final double? parentWidth;
  final double? parentHeight;
  final double? childHeight;
  final double? childWidth;
  final Widget child;
  final AlignmentGeometry? deviceAlignment;

  const DeviceSectionFrame({
    super.key,
    this.parentWidth,
    this.parentHeight,
    this.childHeight,
    this.childWidth,
    this.deviceAlignment,
    required this.child,
  });

  @override
  State<DeviceSectionFrame> createState() => _DeviceSectionFrameState();
}

class _DeviceSectionFrameState extends State<DeviceSectionFrame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: widget.parentWidth ?? AppSizing.kWPercentage(context, 40),
      height: widget.parentHeight ?? AppSizing.kHPercentage(context, 35),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: AppSizing.radiusMd(),
      ),
      child: FittedBox(
        clipBehavior: Clip.hardEdge,
        alignment: widget.deviceAlignment ?? Alignment.bottomCenter,
        fit: BoxFit.cover,
        child: Container(
          width: widget.childWidth ?? AppSizing.kWPercentage(context, 10),
          height: widget.childHeight ?? AppSizing.kWPercentage(context, 22),
          child: AppDeviceFrame(
            deviceInfo: Devices.ios.iPhone13,
            child: Scaffold(
              body: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
