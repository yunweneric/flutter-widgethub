import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/device_frame/device_frame_bloc.dart';
import 'package:flutterui/app/shared/presentation/widgets/device_frame_selector_modal.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';

/// Button widget for selecting device frames in the navbar.
///
/// Displays the current device frame icon and opens the device frame
/// selector modal when clicked.
class DeviceFrameSelectorButton extends StatelessWidget {
  const DeviceFrameSelectorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceFrameBloc, DeviceFrameState>(
      bloc: getIt.get<DeviceFrameBloc>(),
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const DeviceFrameSelectorModal(),
            );
          },
          child: AppIcon(
            icon: AppIcons.mobile,
            size: 20.w,
          ),
        );
      },
    );
  }
}
