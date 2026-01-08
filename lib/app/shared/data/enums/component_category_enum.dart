/// Enumeration of main component categories.
///
/// Defines the top-level categories for organizing components in the library.
enum ComponentCategoryEnum {
  INTRODUCTION,
  GETTING_STARTED,
  TEMPLATES,
  BLOCKS,
  EFFECTS,
  ANIMATIONS;

  /// Returns a human-readable description of this category.
  ///
  /// Converts the enum name to a formatted string (e.g., "GETTING_STARTED" -> "Getting started").
  String describe() {
    return name[0].toUpperCase() + name.split("_").join(" ").substring(1).toLowerCase();
  }

  /// Returns a URL-friendly link string for this category.
  ///
  /// Converts the enum name to a kebab-case string (e.g., "GETTING_STARTED" -> "getting-started").
  String link() {
    return name.split("_").join("-").toLowerCase();
  }

  /// Finds an enum value by its title string.
  ///
  /// [title] The title string to match.
  /// Returns the matching [ComponentCategoryEnum] value.
  ComponentCategoryEnum enumName(String title) {
    return ComponentCategoryEnum.values.firstWhere(
      (e) => e.name.toLowerCase() == title.toLowerCase(),
    );
  }
}
