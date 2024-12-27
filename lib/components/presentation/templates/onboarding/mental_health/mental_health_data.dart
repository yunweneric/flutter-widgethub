import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/templates/onboarding/mental_health/mental_health_code.dart';
import 'package:flutterui/components/presentation/templates/onboarding/mental_health/mental_health_setup.dart';
import 'package:flutterui/components/presentation/templates/onboarding/mental_health/mental_health_widget.dart';

class MentalHealthOnboardingData {
  static Widget widget = const MentalHealthOnboarding();
  static String code = mentalHealthOnboardingCode;
  static String setup = mentalHealthOnboardingSetup;
  static Component component = Component(
    createdAt: DateTime(2024, 12, 26),
    updatedAt: DateTime(2024, 11, 26),
    id: "mental-health-onboarding",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('mentalHealthOnBoardingDescription'),
    title: LangUtil.trans('mentalHealthOnBoardingTitle'),
    setup: setup,
    category: ComponentCategoryEnum.ANIMATIONS,
    subcategory: SubComponentCategoryEnum.ONBOARDING_SCREENS,
    assetLink: "https://github.com/yunweneric/flutter-open-ui/raw/onboarding_ui_ch_3/assets.zip",
    gitHubLink: "https://github.com/yunweneric/flutter-open-ui/tree/onboarding_ui_ch_3",
    supportedPlatforms: [
      SupportedPlatform.ANDROID,
      SupportedPlatform.IOS,
    ],
    responsiveDevices: [AppDeviceType.MOBILE, AppDeviceType.TABLET],
  );
}
