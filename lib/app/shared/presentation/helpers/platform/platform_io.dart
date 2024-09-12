import 'dart:io';

import 'package:flutterui/app/shared/presentation/helpers/platform/platform_enum.dart';

AppPlatform getPlatform() {
  if (Platform.isAndroid) return AppPlatform.android;
  if (Platform.isIOS) return AppPlatform.ios;
  if (Platform.isMacOS) return AppPlatform.mac;
  throw UnimplementedError('Unsupported');
}

dynamic getWindow() {
  throw UnimplementedError('Unsupported');
}

//The test to actually see if there is a connection
Future<bool> checkConnection() async {
  var hasConnection = false;

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      hasConnection = true;
    } else {
      hasConnection = false;
    }
  } on SocketException catch (_) {
    hasConnection = false;
  }

  return hasConnection;
}
