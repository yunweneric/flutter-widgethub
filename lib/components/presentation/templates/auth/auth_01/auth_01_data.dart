import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_01/auth_01_setup.dart';
import 'auth_01_widget.dart';

class Auth01Data {
  static Widget widget = const Auth01Widget();
  static String setup = auth01Setup;

  static Component component = Component(
    createdAt: DateTime(2025, 7, 2),
    updatedAt: DateTime(2025, 7, 2),
    id: "auth-01-signin",
    codeComponents: [CodeComponent(code: auth01Setup, widget: widget)],
    description: LangUtil.trans('auth01Description'),
    title: LangUtil.trans('auth01Title'),
    setup: setup,
    category: ComponentCategoryEnum.TEMPLATES,
    subcategory: SubComponentCategoryEnum.AUTHENTICATION_SCREENS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE],
  );
}
