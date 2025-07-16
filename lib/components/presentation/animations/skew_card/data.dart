import 'dart:io';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/animations/skew_card/code.dart';
import 'package:flutterui/components/presentation/animations/skew_card/widget.dart';

part 'widget.g.dart';

class SkewCardData {
  // Paths to documentation files
  static const String setupPath = 'setup.md';
  static const String usagePath = 'usage.md';

  // Optionally, you can load the setup string from setup.md at build/runtime if needed
  static String get setup => File(setupPath).existsSync() ? File(setupPath).readAsStringSync() : '';
  static String get usage => File(usagePath).existsSync() ? File(usagePath).readAsStringSync() : '';

  static final Component component = Component(
    id: "skew-card-01",
    title: "Skew Card",
    description: "A beautiful animated card with a skew effect.",
    setup: setup, // Loads from setup.md if available
    createdAt: DateTime(2024, 7, 2),
    updatedAt: DateTime(2024, 7, 2),
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.SLIDERS_AND_CAROUSELS,
    codeComponents: [
      CodeComponent(code: skewCardCode, widget: const SkewCard()),
    ],
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE, AppDeviceType.TABLET],
    assetLink: null,
    gitHubLink: null,
  );
}
