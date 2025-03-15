import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/easy_localization_controller.dart';
import 'package:easy_localization/src/localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LangUtil {
  static Future<Localization> loadTranslations(Locale? locale) async {
    await EasyLocalizationController.initEasyLocation();
    final controller = EasyLocalizationController(
      supportedLocales: [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      saveLocale: false,
      assetLoader: const RootBundleAssetLoader(),
      useOnlyLangCode: true,
      useFallbackTranslations: true,
      onLoadError: (FlutterError e) {
        if (kDebugMode) {
          print("initEasyLocation:$e");
        }
      },
    );

    await controller.loadTranslations();
    if (locale != null) await controller.setLocale(locale);
    Localization.load(
      controller.locale,
      translations: controller.translations,
      fallbackTranslations: controller.fallbackTranslations,
    );
    return Localization.instance;
  }

  static String trans(String? key, {Map<String, String>? args, BuildContext? context}) {
    if (key != '' && key != null) {
      String val = tr(key, namedArgs: args, context: context);
      return val;
    } else
      return '';
  }

  static bool isFrench(BuildContext context) {
    return context.deviceLocale.languageCode == 'fr';
  }

  static Future<void> setTrans(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
  }
}
