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
}
