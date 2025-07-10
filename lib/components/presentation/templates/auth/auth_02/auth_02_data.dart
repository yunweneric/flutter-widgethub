import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_02/auth_02_code.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_02/auth_02_setup.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_02/auth_02_widget.dart';

class Auth02Data {
  static Widget widget = const Auth02Widget();
  static String code = auth02Code;
  static String setup = auth02Setup;
  static Component component = Component(
    createdAt: DateTime(2025, 7, 3),
    updatedAt: DateTime(2025, 7, 3),
    id: "auth-02-signup",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('auth02Description'),
    title: LangUtil.trans('auth02Title'),
    setup: setup,
    category: ComponentCategoryEnum.TEMPLATES,
    subcategory: SubComponentCategoryEnum.AUTHENTICATION_SCREENS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE],
  );
}
