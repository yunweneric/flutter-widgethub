import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_05/auth_05_code.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_05/auth_05_setup.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_05/auth_05_widget.dart';

class Auth05Data {
  static Widget widget = const Auth05Widget();
  static String code = auth05Code;
  static String setup = auth05Setup;
  static Component component = Component(
    createdAt: DateTime(2025, 7, 6),
    updatedAt: DateTime(2025, 7, 6),
    id: "auth-05-profile",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('auth05Description'),
    title: LangUtil.trans('auth05Title'),
    setup: setup,
    category: ComponentCategoryEnum.TEMPLATES,
    subcategory: SubComponentCategoryEnum.AUTHENTICATION_SCREENS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE],
  );
}
