import 'package:flutterui/app/shared/presentation/helpers/platform/platform_enum.dart';
import "dart:html" as html;

AppPlatform getPlatform() {
  return AppPlatform.web;
}

dynamic getWindow() {
  return html.window;
}

void openUrl(String url) {
  html.window.open(url, '_blank');
}

//The test to actually see if there is a connection
Future<bool> checkConnection() async {
  const hasConnection = true;

  // try {
  //   final result = await InternetAddress.lookup('google.com');
  //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //     hasConnection = true;
  //   } else {
  //     hasConnection = false;
  //   }
  //   // } on SocketException catch (_) {
  //   //   hasConnection = false;
  //   // }
  // } catch (_) {
  //   hasConnection = false;
  // }
  return hasConnection;
}
