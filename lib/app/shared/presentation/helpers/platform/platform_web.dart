import 'package:flutterui/app/shared/presentation/helpers/platform/platform_enum.dart';
import 'package:web/web.dart' as web;

AppPlatform getPlatform() {
  return AppPlatform.web;
}

dynamic getWindow() {
  return web.window;
}

void openUrl(String url) {
  web.window.open(url, '_blank', 'noopener,noreferrer');
}

//The test to actually see if there is a connection
Future<bool> checkConnection() async {
  return true;
}
