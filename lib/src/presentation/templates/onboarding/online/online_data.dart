import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/src/presentation/templates/onboarding/online/online_code.dart';
import 'package:flutterui/src/presentation/templates/onboarding/online/online_setup.dart';
import 'package:flutterui/src/presentation/templates/onboarding/online/online_widget.dart';

class OnlineOnboardingData {
  static Widget widget = const OnlineOnboarding();
  static String code = onlineOnboardingCode;
  static String setup = onlineOnboardingSetup;
  static Component component = Component(
    createdAt: DateTime(2024, 12, 22),
    updatedAt: DateTime(2024, 12, 22),
    id: "online-onboarding-onboarding",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('onlineOnBoardingDescription'),
    title: LangUtil.trans('onlineOnBoardingTitle'),
    setup: setup,
    category: ComponentCategoryEnum.ANIMATIONS,
    subcategory: SubComponentCategoryEnum.ONBOARDING_SCREENS,
    assetLink: "https://github.com/yunweneric/flutter-open-ui/raw/onboarding_ui_ch_2/assets.zip",
    gitHubLink: "https://github.com/yunweneric/flutter-open-ui/tree/onboarding_ui_ch_2",
    supportedPlatforms: [
      SupportedPlatform.ANDROID,
      SupportedPlatform.IOS,
    ],
    responsiveDevices: [AppDeviceType.MOBILE, AppDeviceType.TABLET],
  );
}
