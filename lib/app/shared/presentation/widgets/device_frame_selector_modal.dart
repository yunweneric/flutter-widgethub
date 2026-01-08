import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/device_frame/device_frame_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';

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
          return name.contains('galaxy') || name.contains('pixel') || 
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
              maxWidth: 800.w,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Device Frame',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (iosDevices.isNotEmpty) ...[
                          _PlatformSection(
                            title: 'iOS',
                            devices: iosDevices,
                            selectedDevice: selectedDevice,
                          ),
                          const SizedBox(height: 20),
                        ],
                        if (androidDevices.isNotEmpty) ...[
                          _PlatformSection(
                            title: 'Android',
                            devices: androidDevices,
                            selectedDevice: selectedDevice,
                          ),
                          const SizedBox(height: 20),
                        ],
                        if (macOSDevices.isNotEmpty) ...[
                          _PlatformSection(
                            title: 'macOS',
                            devices: macOSDevices,
                            selectedDevice: selectedDevice,
                          ),
                          const SizedBox(height: 20),
                        ],
                        if (windowsDevices.isNotEmpty) ...[
                          _PlatformSection(
                            title: 'Windows',
                            devices: windowsDevices,
                            selectedDevice: selectedDevice,
                          ),
                          const SizedBox(height: 20),
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
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
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
      borderRadius: AppSizing.radiusMd(),
      child: Container(
        width: 120.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).dividerColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: AppSizing.radiusMd(),
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Theme.of(context).cardColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 80.h,
              child: DeviceFrame(
                device: device,
                isFrameVisible: true,
                orientation: Orientation.portrait,
                screen: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Center(
                    child: Icon(
                      Icons.phone_android,
                      size: 20.w,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              device.name,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (isSelected) ...[
              const SizedBox(height: 4),
              Icon(
                Icons.check_circle,
                size: 16.w,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
