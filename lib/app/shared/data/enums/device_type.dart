import 'package:flutterui/app/shared/presentation/utils/icons.dart';

enum AppDeviceType {
  MOBILE,
  TABLET,
  DESKTOP;

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

  String generateIcon() {
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
