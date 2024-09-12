// import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutterui/app/shared/presentation/helpers/platform/platform.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:device_frame/device_frame.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';

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

  static String generateUniqueId({String prefix = ' "FWH-', int length = 7}) {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    // final StringBuffer result = StringBuffer(prefix);

    // for (int i = 0; i < length; i++) {
    //   final int randomIndex = (characters.length * (new DateTime.now().millisecondsSinceEpoch % 1000) / 1000).toInt();
    //   result.write(characters[randomIndex]);
    // }

    // return result.toString();

    Random random = Random();
    final items = List.generate(length - 4, (index) => chars[random.nextInt(chars.length)]);
    return prefix + items.join();
  }

  static findDevice({required AppDeviceType type}) {
    if (type == AppDeviceType.MOBILE) return Devices.android.samsungGalaxyS20;
    // if (type == AppDeviceType.MOBILE) return Devices.ios.iPhone12ProMax;
    if (type == AppDeviceType.TABLET) return Devices.android.largeTablet;
    if (type == AppDeviceType.DESKTOP) return Devices.macOS.wideMonitor;
  }
}
