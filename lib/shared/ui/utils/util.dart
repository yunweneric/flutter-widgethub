import 'dart:io';

import 'package:device_frame/device_frame.dart';
import 'package:flutterui/shared/data/enums/device_type.dart';

class UtilHelper {
  static convertWidgetToString(String location) async {
    try {
      final file = File(location);
      final contents = await file.readAsString();

      print(contents);
      return contents;
    } catch (e) {
      print(e);

      return '';
    }
  }

  static findDevice({required AppDeviceType type}) {
    if (type == AppDeviceType.MOBILE) return Devices.android.samsungGalaxyS20;
    // if (type == AppDeviceType.MOBILE) return Devices.ios.iPhone12ProMax;
    if (type == AppDeviceType.TABLET) return Devices.android.largeTablet;
    if (type == AppDeviceType.DESKTOP) return Devices.macOS.wideMonitor;
  }
}
