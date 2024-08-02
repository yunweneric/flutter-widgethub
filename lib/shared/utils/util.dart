import 'dart:io';

class UtilHelper {
  static convertWidgetToString(String location) async {
    try {
      final file = File(location);
      final contents = await file.readAsString();

      print(contents);
      return contents;
    } catch (e) {
      print(e);

      return '';
    }
  }
}
