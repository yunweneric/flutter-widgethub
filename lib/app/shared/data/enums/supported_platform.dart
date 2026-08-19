/// Enumeration of supported platforms.
///
/// Defines the platforms that components can run on (Web, Android, iOS, etc.).
library;

import 'package:flutterui/app/shared/presentation/utils/icons.dart';

enum SupportedPlatform {
  WEB,
  ANDROID,
  LINUX,
  MACOS,
  IOS;

  /// Returns a human-readable description of this platform.
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

  /// Returns the icon for this platform, for rendering with `AppIcon`.
  ///
  /// macOS and iOS share the Apple mark: at pill size the two read as one
  /// glyph anyway, and the label already separates them.
  AppIconData icon() {
    switch (this) {
      case SupportedPlatform.WEB:
        return AppIcons.web;
      case SupportedPlatform.ANDROID:
        return AppIcons.android;
      case SupportedPlatform.LINUX:
        return AppIcons.linux;
      case SupportedPlatform.MACOS:
        return AppIcons.apple;
      case SupportedPlatform.IOS:
        return AppIcons.apple;
    }
  }
}
