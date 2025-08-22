import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';

import 'airnbnb_setup.dart';
import 'index.dart';

class AirbnbData {
  static String setup = airbnbSetup;

  static Component component = Component(
    createdAt: DateTime(2025, 8, 21),
    updatedAt: DateTime(2025, 8, 21),
    id: "airbnb-redesign-ui",
    codeComponents: [
      CodeComponent(code: explore1Code, widget: const AirbnbLayout(initialIndex: 0)),
      CodeComponent(code: explore3Code, widget: const Explore3()),
      CodeComponent(code: explore2Code, widget: const AirbnbLayout(initialIndex: 1)),
    ],
    description: LangUtil.trans('airbnbDescription'),
    title: LangUtil.trans('airbnbTitle'),
    setup: setup,
    category: ComponentCategoryEnum.TEMPLATES,
    subcategory: SubComponentCategoryEnum.APPS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE],
  );
}
