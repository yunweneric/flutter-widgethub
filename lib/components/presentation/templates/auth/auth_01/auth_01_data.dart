import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_01/auth_01_setup.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_01/login/code.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_01/login/widget.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_01/register/code.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_01/register/widget.dart';

class Auth01Data {
  static String setup = auth01Setup;

  static Component component = Component(
    createdAt: DateTime(2025, 7, 2),
    updatedAt: DateTime(2025, 7, 2),
    id: "auth-01-signin",
    codeComponents: [
      CodeComponent(code: authLoginCode, widget: const Auth01LoginWidget()),
      CodeComponent(code: auth01RegisterCode, widget: const Auth01RegisterWidget())
    ],
    description: LangUtil.trans('auth01Description'),
    title: LangUtil.trans('auth01Title'),
    setup: setup,
    category: ComponentCategoryEnum.TEMPLATES,
    subcategory: SubComponentCategoryEnum.AUTHENTICATION_SCREENS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE],
  );
}
