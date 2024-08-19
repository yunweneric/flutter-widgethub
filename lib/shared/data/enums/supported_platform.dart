enum SupportedPlatform {
  WEB,
  ANDROID,
  LINUX,
  MACOS,
  IOS;

  String describe() {
    switch (this) {
      case SupportedPlatform.WEB:
        return 'Web';
      case SupportedPlatform.ANDROID:
        return 'Android';
      case SupportedPlatform.LINUX:
        return 'Linux';
      case SupportedPlatform.MACOS:
        return 'MacOs';
      case SupportedPlatform.IOS:
        return 'Ios';
    }
  }
}
