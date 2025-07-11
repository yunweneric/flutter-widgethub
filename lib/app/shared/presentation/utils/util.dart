// import 'dart:html' as platform_io;

// ignore: conditional_import
// import 'dart:io' if (dart.library.html) 'dart:html' as platform_io;

import 'package:device_frame/device_frame.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/presentation/helpers/platform/platform.dart';

class UtilHelper {
  static String activeRoute = getIt.get<GoRouter>().routeInformationProvider.value.uri.path;

  static dynamic getWindows() {
    final windows = getWindow();
    return windows;
  }

  static Future<void> openUrl(String? link) async {
    if (link == null) {
      throw Exception('Could not launch $link');
    }

    if (kIsWeb) {
      final windows = getWindows();
      windows.location.href = link;
    } else {
      final uri = Uri.parse(link);
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
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

  static findDevice({required AppDeviceType type}) {
    if (type == AppDeviceType.MOBILE) return Devices.ios.iPhone13;
    // if (type == AppDeviceType.MOBILE) return Devices.ios.iPhone12ProMax;
    if (type == AppDeviceType.TABLET) return Devices.android.largeTablet;
    if (type == AppDeviceType.DESKTOP) return Devices.macOS.macBookPro;
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
