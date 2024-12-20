import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LangUtil {
  static String trans(String? key, {List<String>? args, Map<String, String>? namedArgs, BuildContext? context}) {
    if (key != '' && key != null) {
      String val = tr(key, args: args, context: context, namedArgs: namedArgs);
      return val;
    } else {
      return '';
    }
  }

  static bool isFrench(BuildContext context) {
    return context.deviceLocale.languageCode == 'fr';
  }

  static Future<void> setTrans(BuildContext context, String lang) async {
    await context.setLocale(Locale(lang));
  }
}
