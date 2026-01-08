/// Device frame management BLoC.
///
/// Manages the selected device frame state and handles device frame changes.
/// Uses HydratedBloc to persist device frame preference across app restarts.
import 'package:device_frame/device_frame.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'device_frame_event.dart';
part 'device_frame_state.dart';

/// BLoC for managing device frame selection state.
///
/// Handles device frame changes and persists the selected device frame using
/// HydratedBloc. Initializes with iPhone 13 as the default device.
class DeviceFrameBloc extends HydratedBloc<DeviceFrameEvent, DeviceFrameState> {
  /// Creates a device frame bloc with iPhone 13 as initial device.
  DeviceFrameBloc() : super(DeviceFrameState(selectedDeviceInfo: Devices.ios.iPhone13)) {
    on<UpdateDeviceFrameEvent>((event, emit) {
      emit(state.copyWith(selectedDeviceInfo: event.deviceInfo));
    });
  }

  @override
  DeviceFrameState? fromJson(Map<String, dynamic> json) {
    try {
      // Find the device by name from all available devices
      final deviceName = json['deviceName'] as String;
      final device = Devices.all.firstWhere(
        (d) => d.name == deviceName,
        orElse: () => Devices.ios.iPhone13,
      );
      return DeviceFrameState(selectedDeviceInfo: device);
    } catch (e) {
      return DeviceFrameState(selectedDeviceInfo: Devices.ios.iPhone13);
    }
  }

  @override
  Map<String, dynamic>? toJson(DeviceFrameState state) {
    return {
      'deviceName': state.selectedDeviceInfo.name,
    };
  }
}
