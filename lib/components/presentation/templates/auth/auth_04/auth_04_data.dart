import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_04/auth_04_code.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_04/auth_04_setup.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_04/auth_04_widget.dart';

class Auth04Data {
  static Widget widget = const Auth04Widget();
  static String code = auth04Code;
  static String setup = auth04Setup;
  static Component component = Component(
    createdAt: DateTime(2025, 7, 5),
    updatedAt: DateTime(2025, 7, 5),
    id: "auth-04-otp",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('auth04Description'),
    title: LangUtil.trans('auth04Title'),
    setup: setup,
    category: ComponentCategoryEnum.TEMPLATES,
    subcategory: SubComponentCategoryEnum.AUTHENTICATION_SCREENS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE],
  );
}
