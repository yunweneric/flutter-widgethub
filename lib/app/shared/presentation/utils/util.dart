/// General utility helper functions.
///
/// Provides various utility methods for common operations including:
/// - URL launching
/// - Clipboard operations
/// - Component counting and formatting
/// - Window management (web)
library;

import 'package:device_frame/device_frame.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/presentation/helpers/platform/platform.dart';

/// Utility class providing helper methods for common operations.
class UtilHelper {
  static String activeRoute =
      getIt.get<GoRouter>().routeInformationProvider.value.uri.path;

  static dynamic getWindows() {
    return getWindow();
  }

  /// Opens [link] outside the app — a new browser tab on web, the platform
  /// browser elsewhere.
  ///
  /// Web goes through `url_launcher` rather than `dart:html` directly: the
  /// html shim is unavailable in the `--wasm` build the site ships, so the
  /// conditional import fell back to a stub that threw and every external
  /// link (the GitHub button included) silently did nothing.
  static Future<void> openUrl(String? link) async {
    if (link == null) {
      throw Exception('Could not launch $link');
    }

    final uri = Uri.parse(link);
    final bool launched = kIsWeb
        ? await launchUrl(uri, webOnlyWindowName: '_blank')
        : await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      throw Exception('Could not launch $uri');
    }
  }

  static Future<void> copy(BuildContext context, {required String data}) async {
    await Clipboard.setData(ClipboardData(text: data));
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     width: 200,
    //     margin: const EdgeInsets.symmetric(horizontal: 10),
    //     content: Text('Copied to Clipboard!'),
    //     showCloseIcon: true,
    //   ),
    //   // snackBarAnimationStyle: AnimationStyle(curve: Curves.bounceIn),
    // );
  }

  static DeviceInfo findDevice({required AppDeviceType type}) {
    switch (type) {
      case AppDeviceType.MOBILE:
        return Devices.ios.iPhone13;
      case AppDeviceType.TABLET:
        return Devices.android.largeTablet;
      case AppDeviceType.DESKTOP:
        return Devices.macOS.macBookPro;
    }
  }

  static String formatNumber(int length) {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(length);
  }

  static String countComponents(List<Component> components) {
    final count = components.fold(0, (a, b) {
      final codeComponentCount = b.codeComponents.length;
      return a + codeComponentCount;
    });
    return formatNumber(count);
  }
}
