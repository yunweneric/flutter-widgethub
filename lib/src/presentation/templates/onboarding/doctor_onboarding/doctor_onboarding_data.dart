import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/src/presentation/templates/onboarding/doctor_onboarding/doctor_onboarding_code.dart';
import 'package:flutterui/src/presentation/templates/onboarding/doctor_onboarding/doctor_onboarding_setup.dart';
import 'package:flutterui/src/presentation/templates/onboarding/doctor_onboarding/doctor_onboarding_widget.dart';

class DoctorOnboardingData {
  static Widget widget = const DoctorOnboardingScreen();
  static String code = doctorOnboardingCode;
  static String setup = doctorOnboardingSetup;
  static Component component = Component(
    createdAt: DateTime(2024, 11, 28),
    updatedAt: DateTime(2024, 11, 28),
    id: "doctor-appointment-boarding",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('doctorOnBoardingDescription'),
    title: LangUtil.trans('doctorOnBoardingTitle'),
    setup: setup,
    category: ComponentCategoryEnum.ANIMATIONS,
    subcategory: SubComponentCategoryEnum.ONBOARDING_SCREENS,
    assetLink: "https://github.com/yunweneric/flutter-open-ui/raw/9-implement-the-ui-for-doctor-onboarding/assets.zip",
    gitHubLink: "https://github.com/yunweneric/flutter-open-ui/tree/9-implement-the-ui-for-doctor-onboarding",
    supportedPlatforms: [
      SupportedPlatform.ANDROID,
      SupportedPlatform.IOS,
    ],
    responsiveDevices: [AppDeviceType.MOBILE, AppDeviceType.TABLET],
  );
}
