import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/device_frame/device_frame_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';

class AppDeviceFrame extends StatefulWidget {
  final DeviceInfo? deviceInfo;
  final Widget child;
  final Orientation? orientation;
  final bool? isFrameVisible;

  const AppDeviceFrame({
    super.key,
    this.deviceInfo,
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
    return BlocBuilder<DeviceFrameBloc, DeviceFrameState>(
      bloc: getIt.get<DeviceFrameBloc>(),
      builder: (context, state) {
        final deviceInfo = widget.deviceInfo ?? state.selectedDeviceInfo;

        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(),
          width: AppSizing.width(context),
          height: AppSizing.isMobile(context)
              ? AppSizing.height(context) * 0.5
              : AppSizing.height(context) * 0.6,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: widget.isFrameVisible == false
                ? SizedBox(
                    width: AppSizing.kWPercentage(context, 40),
                    child: widget.child,
                  )
                : DeviceFrame(
                    device: deviceInfo,
                    isFrameVisible: widget.isFrameVisible!,
                    orientation: widget.orientation!,
                    screen: widget.child,
                  ),
          ),
        );
      },
    );
  }
}
