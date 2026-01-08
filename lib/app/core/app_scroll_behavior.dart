/// Custom scroll behavior for the application.
///
/// Extends [MaterialScrollBehavior] to enable drag scrolling on multiple
/// input device types including touch, mouse, and trackpad.
import 'dart:ui';

import 'package:flutter/material.dart';

/// Custom scroll behavior that supports dragging on various input devices.
///
/// This behavior allows users to drag scroll using touch, mouse, or trackpad
/// input, providing a consistent scrolling experience across platforms.
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  /// Returns the set of pointer device kinds that support drag scrolling.
  ///
  /// Includes touch, mouse, and trackpad devices to enable drag scrolling
  /// on desktop, mobile, and tablet platforms.
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
