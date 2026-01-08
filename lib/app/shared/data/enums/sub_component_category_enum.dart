/// Enumeration of subcomponent categories.
///
/// Defines the subcategories within each main component category.
/// These are used for more granular organization and filtering of components.
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';

enum SubComponentCategoryEnum {
  GETTING_STARTED,
  REQUEST_A_COMPONENT,
  ALL_COMPONENTS,

  APPS,
  ONBOARDING_SCREENS,
  HOME_SCREENS,
  AUTHENTICATION_SCREENS,
  KITS,

  SWITCHERS,
  INPUTS,
  TEXTS,
  TABS,
  LOADERS,
  BUTTONS,
  BOTTOM_NAV_BARS,
  DRAWERS,
  SLIDERS_AND_CAROUSELS,

  LINEAR_GRADIENTS;

  /// Returns a localized description of this subcategory.
  ///
  /// Uses the translation system to return a human-readable, localized string.
  String describe() {
    // return name[0].toUpperCase() + name.split("_").join(" ").substring(1).toLowerCase();
    // final description = name[0].toUpperCase() + name.split("_").join(" ").substring(1).toLowerCase();
    return LangUtil.trans(name);
    // return name;
  }

  /// Returns a URL-friendly link string for this subcategory.
  ///
  /// Converts the enum name to a kebab-case string.
  String link() {
    return name.split("_").join("-").toLowerCase();
  }
}
