// import 'dart:io';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

import 'package:device_frame/device_frame.dart';
import 'package:flutterui/shared/data/enums/device_type.dart';

class UtilHelper {
  static Future<void> openUrl(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
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
