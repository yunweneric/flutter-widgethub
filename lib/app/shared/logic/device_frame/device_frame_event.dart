part of 'device_frame_bloc.dart';

/// Event for updating the selected device frame.
class UpdateDeviceFrameEvent extends DeviceFrameEvent {
  final DeviceInfo deviceInfo;

  UpdateDeviceFrameEvent({required this.deviceInfo});
}

/// Base class for device frame events.
abstract class DeviceFrameEvent {}
