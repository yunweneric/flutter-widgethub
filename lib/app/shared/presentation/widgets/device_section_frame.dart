import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/device_frame.dart';

/// Muted, rounded canvas hosting a scaled-down live device preview.
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
    final tokens = context.tokens;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg),
      width: widget.parentWidth ?? AppSizing.kWPercentage(context, 40),
      height: widget.parentHeight ?? AppSizing.kHPercentage(context, 35),
      decoration: BoxDecoration(
        color: tokens.muted.withValues(alpha: 0.5),
        borderRadius: AppRadii.lgAll,
        border: Border.all(color: tokens.border),
      ),
      child: FittedBox(
        clipBehavior: Clip.hardEdge,
        alignment: widget.deviceAlignment ?? Alignment.bottomCenter,
        fit: BoxFit.cover,
        child: SizedBox(
          width: widget.childWidth ?? AppSizing.kWPercentage(context, 10),
          height: widget.childHeight ?? AppSizing.kWPercentage(context, 22),
          child: AppDeviceFrame(
            child: Scaffold(
              body: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
