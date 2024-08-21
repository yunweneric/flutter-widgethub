enum ComponentCategoryEnum {
  GETTING_STARTED,
  TEMPLATES,
  BLOCKS,
  EFFECTS,
  ANIMATIONS;

  String describe() {
    return name[0].toUpperCase() + name.split("_").join(" ").substring(1).toLowerCase();
  }

  String link() {
    return name.split("_").join("-").toLowerCase();
  }
}
