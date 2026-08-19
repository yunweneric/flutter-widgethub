import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/device_frame/device_frame_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

/// Modal dialog for selecting a device frame.
///
/// Displays all available device frames from the device_frame package
/// in a grid layout, grouped by platform.
class DeviceFrameSelectorModal extends StatelessWidget {
  const DeviceFrameSelectorModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceFrameBloc, DeviceFrameState>(
      bloc: getIt.get<DeviceFrameBloc>(),
      builder: (context, state) {
        final selectedDevice = state.selectedDeviceInfo;

        // Group devices by platform based on device name patterns
        final allDevices = Devices.all;
        final iosDevices = allDevices.where((d) {
          final name = d.name.toLowerCase();
          return name.contains('iphone') || name.contains('ipad');
        }).toList();
        final androidDevices = allDevices.where((d) {
          final name = d.name.toLowerCase();
          return name.contains('galaxy') ||
              name.contains('pixel') ||
              (name.contains('android') && !name.contains('iphone'));
        }).toList();
        final macOSDevices = allDevices.where((d) {
          final name = d.name.toLowerCase();
          return name.contains('mac');
        }).toList();
        final windowsDevices = allDevices.where((d) {
          final name = d.name.toLowerCase();
          return name.contains('windows') || name.contains('surface');
        }).toList();
        final linuxDevices = allDevices.where((d) {
          final name = d.name.toLowerCase();
          return name.contains('linux');
        }).toList();

        return Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: AppSizing.radiusMd(),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 700.w,
              maxHeight: MediaQuery.of(context).size.height * 0.75,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Device Frame',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        icon: AppIcon(
                          icon: AppIcons.close,
                          size: 20.w,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (iosDevices.isNotEmpty) ...[
                          _PlatformSection(
                            title: 'iOS',
                            devices: iosDevices,
                            selectedDevice: selectedDevice,
                          ),
                          SizedBox(height: 24.h),
                        ],
                        if (androidDevices.isNotEmpty) ...[
                          _PlatformSection(
                            title: 'Android',
                            devices: androidDevices,
                            selectedDevice: selectedDevice,
                          ),
                          SizedBox(height: 24.h),
                        ],
                        if (macOSDevices.isNotEmpty) ...[
                          _PlatformSection(
                            title: 'macOS',
                            devices: macOSDevices,
                            selectedDevice: selectedDevice,
                          ),
                          SizedBox(height: 24.h),
                        ],
                        if (windowsDevices.isNotEmpty) ...[
                          _PlatformSection(
                            title: 'Windows',
                            devices: windowsDevices,
                            selectedDevice: selectedDevice,
                          ),
                          SizedBox(height: 24.h),
                        ],
                        if (linuxDevices.isNotEmpty) ...[
                          _PlatformSection(
                            title: 'Linux',
                            devices: linuxDevices,
                            selectedDevice: selectedDevice,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Platform section widget that displays devices for a specific platform.
class _PlatformSection extends StatelessWidget {
  final String title;
  final List<DeviceInfo> devices;
  final DeviceInfo selectedDevice;

  const _PlatformSection({
    required this.title,
    required this.devices,
    required this.selectedDevice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: devices.map((device) {
            final isSelected = device.name == selectedDevice.name;
            return _DeviceCard(
              device: device,
              isSelected: isSelected,
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// Device card widget that displays a single device preview.
class _DeviceCard extends StatelessWidget {
  final DeviceInfo device;
  final bool isSelected;

  const _DeviceCard({
    required this.device,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final deviceFrameBloc = getIt.get<DeviceFrameBloc>();

    return InkWell(
      onTap: () {
        deviceFrameBloc.add(UpdateDeviceFrameEvent(deviceInfo: device));
        Navigator.of(context).pop();
      },
      borderRadius: AppSizing.radiusSm(),
      child: Stack(
        children: [
          Container(
            width: 100.w,
            height: 120.h,
            // alignment: Alignment.bottomCtopenter,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).dividerColor,
                width: isSelected ? 1.5 : 1,
              ),
              borderRadius: AppSizing.radiusSm(),
              color: isSelected
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.08)
                  : Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.h,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: DeviceFrame(
                      device: device,
                      isFrameVisible: true,
                      orientation: Orientation.portrait,
                      screen: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Center(
                          child: AppIcon(
                            icon: AppIcons.mobile,
                            size: 12.w,
                            color: Theme.of(context)
                                .iconTheme
                                .color
                                ?.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  device.name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 10.sp,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (isSelected) ...[
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: AppIcon(
                icon: AppIcons.checkCircle,
                size: 18.w,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
