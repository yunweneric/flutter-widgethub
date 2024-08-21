enum SubComponentCategoryEnum {
  GETTING_STARTED,
  REQUEST_A_COMPONENT,

  APP_CLONES,
  ONBOARDINGS_SCREENS,
  HOME_SCREENS,
  AUTHENTICATION_SCREENS,

  SWITCHERS,
  INPUT,
  TEXT,
  LOADERS,
  BUTTONS,
  BOTTOM_NAV_BARS,
  DRAWERS,
  SLIDERS_AND_CAROUSELS,

  LINEAR_GRADIENTS;

  String describe() {
    return name[0].toUpperCase() + name.split("_").join(" ").substring(1).toLowerCase();
  }

  String link() {
    return name.split("_").join("-").toLowerCase();
  }
}
