import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_03/auth_03_code.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_03/auth_03_setup.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_03/auth_03_widget.dart';

class Auth03Data {
  static Widget widget = const Auth03Widget();
  static String code = auth03Code;
  static String setup = auth03Setup;
  static Component component = Component(
    createdAt: DateTime(2025, 7, 4),
    updatedAt: DateTime(2025, 7, 4),
    id: "auth-03-forgot-password",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('auth03Description'),
    title: LangUtil.trans('auth03Title'),
    setup: setup,
    category: ComponentCategoryEnum.TEMPLATES,
    subcategory: SubComponentCategoryEnum.AUTHENTICATION_SCREENS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE],
  );
}
