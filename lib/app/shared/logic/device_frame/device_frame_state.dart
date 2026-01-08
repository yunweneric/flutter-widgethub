part of 'device_frame_bloc.dart';

/// State for device frame selection.
class DeviceFrameState {
  final DeviceInfo selectedDeviceInfo;

  DeviceFrameState({required this.selectedDeviceInfo});

  DeviceFrameState copyWith({DeviceInfo? selectedDeviceInfo}) {
    return DeviceFrameState(
      selectedDeviceInfo: selectedDeviceInfo ?? this.selectedDeviceInfo,
    );
  }
}
