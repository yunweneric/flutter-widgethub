import 'package:flutterui/core/platform/platform_enum.dart';

AppPlatform getPlatform() {
  throw UnimplementedError('Unsupported');
}

dynamic getWindow() {
  throw UnimplementedError('Unsupported');
}

//The test to actually see if there is a connection
Future<bool> checkConnection() async {
  throw UnimplementedError('Unsupported');
}
