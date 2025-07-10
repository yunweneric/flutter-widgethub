import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/components/presentation/templates/basuu/exports/basuu_choose_category_screen_code.dart';
import 'package:flutterui/components/presentation/templates/basuu/exports/basuu_choose_language_screen_code.dart';
import 'package:flutterui/components/presentation/templates/basuu/exports/basuu_home_screen_code.dart';
import 'package:flutterui/components/presentation/templates/basuu/exports/basuu_setup.dart';
import 'package:flutterui/components/presentation/templates/basuu/exports/basuu_splash_screen_code.dart';
import 'package:flutterui/components/presentation/templates/basuu/models/basuu_category.dart';
import 'package:flutterui/components/presentation/templates/basuu/screens/basuu_choose_category_screen.dart';
import 'package:flutterui/components/presentation/templates/basuu/screens/basuu_choose_language_screen.dart';
import 'package:flutterui/components/presentation/templates/basuu/screens/basuu_home_screen.dart';
import 'package:flutterui/components/presentation/templates/basuu/screens/basuu_learning_screen.dart';
import 'package:flutterui/components/presentation/templates/basuu/screens/basuu_pre_start_screen.dart';
import 'package:flutterui/components/presentation/templates/basuu/screens/basuu_splash_screen.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/templates/basuu/shared/utils/basuu_colors.dart';

class BasuuData {
  static List<BasuuCategory> categories = [
    BasuuCategory(label: "A1", title: "1 - 100", color: BasuuColors.TEAL, percentage: 80, isChecked: true),
    BasuuCategory(label: "A2", title: '101 - 1K', color: BasuuColors.DGREEN, percentage: 44),
    BasuuCategory(label: "B1", title: "1K - 2K", color: BasuuColors.DARKORANGE, percentage: 27),
    BasuuCategory(label: "B2", title: "2K - 3K", color: BasuuColors.DARKRED, percentage: 9),
    BasuuCategory(label: "C1", title: "3K - 4K", color: BasuuColors.MIDRED),
    BasuuCategory(label: "C2", title: '4K - 5K', color: BasuuColors.DEEPRED),
  ];
  static Component component = Component(
    id: "basuu-language-kit",
    createdAt: DateTime(2024, 10, 15),
    updatedAt: DateTime(2024, 10, 15),
    codeComponents: [
      CodeComponent(code: basuuSplashScreenCode, widget: const BasuuSplashScreen()),
      CodeComponent(code: basuuChooseCategoryScreenCode, widget: const BasuuChooseCategoryScreen()),
      CodeComponent(code: basuuChooseLanguageScreenCode, widget: const BasuuChooseLanguageScreen()),
      CodeComponent(
        code: basuuChooseLanguageScreenCode,
        widget: BasuuLearningScreen(selectedCategory: categories.first),
      ),
      CodeComponent(
        code: basuuChooseLanguageScreenCode,
        widget: BasuuPreStartScreen(categories: categories),
      ),
      CodeComponent(
        code: basuuHomeScreenCode,
        widget: BasuuHomeScreen(level: categories.first),
      ),
    ],
    description:
        'An Animated Language learning App Template including, learning Home screen, Language screen, Word learning screen and more',
    title: 'Basuu App',
    setup: basuuSetup,
    category: ComponentCategoryEnum.TEMPLATES,
    subcategory: SubComponentCategoryEnum.APPS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    assetLink: 'https://github.com/yunweneric/flutter-open-ui/raw/refs/heads/language_app/assets.zip',
    gitHubLink: 'https://github.com/yunweneric/flutter-open-ui/tree/language_app',
    responsiveDevices: [AppDeviceType.MOBILE],
  );
}
