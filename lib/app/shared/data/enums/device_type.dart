/// Enumeration of device types for responsive design.
///
/// Defines the different device form factors that components can target.
library;

import 'package:flutterui/app/shared/presentation/utils/icons.dart';

enum AppDeviceType {
  MOBILE,
  TABLET,
  DESKTOP;

  /// Returns a human-readable description of this device type.
  String describe() {
    switch (this) {
      case AppDeviceType.MOBILE:
        return 'Mobile';
      case AppDeviceType.TABLET:
        return 'Tablet';
      case AppDeviceType.DESKTOP:
        return 'Desktop';
    }
  }

  /// Returns the icon identifier for this device type.
  ///
  /// Returns the icon name from [AppIcons] corresponding to this device type.
  AppIconData generateIcon() {
    switch (this) {
      case AppDeviceType.MOBILE:
        return AppIcons.mobile;
      case AppDeviceType.TABLET:
        return AppIcons.tablet;
      case AppDeviceType.DESKTOP:
        return AppIcons.desktop;
    }
  }
}
