import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/app/core/app.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/templates/doctor_onboarding/doctor_onboarding_widget.dart';
import 'package:flutterui/components/presentation/templates/fade_carousel/fade_carousel_code.dart';
import 'package:flutterui/components/presentation/templates/fade_carousel/fade_carousel_setup.dart';

class DoctorOnboardingData {
  static Widget widget = const OnboardingScreen();
  static String code = fadeCarouselCode;
  static String setup = fadeCarouselSetup;
  static Component component = Component(
    createdAt: DateTime(2024, 11, 28),
    updatedAt: DateTime(2024, 11, 28),
    id: "doctor-appointment-boarding",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: 'doctorOnBoardingDescription'.tr(),
    title: 'doctorOnBoardingTitle'.tr(),
    setup: setup,
    category: ComponentCategoryEnum.ANIMATIONS,
    subcategory: SubComponentCategoryEnum.ONBOARDING_SCREENS,
    assetLink: "https://github.com/yunweneric/flutter-open-ui/raw/9-implement-the-ui-for-doctor-onboarding/assets.zip",
    gitHubLink: "https://github.com/yunweneric/flutter-open-ui/tree/9-implement-the-ui-for-doctor-onboarding",
    supportedPlatforms: [
      SupportedPlatform.ANDROID,
      SupportedPlatform.IOS,
    ],
  );
}
