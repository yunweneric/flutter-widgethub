import 'package:flutterui/app/core/app.dart';
import 'package:flutterui/app/core/boostrap.dart';
import 'package:flutterui/app/core/config.dart';

void main() {
  bootstrap(() => const MyApp(), env: AppEnv.PROD);
}
