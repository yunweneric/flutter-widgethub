enum SubComponentCategory {
  TEXT,
  INPUT,
  EFFECTS,
  ANIMATIONS;

  String describe() {
    switch (this) {
      case SubComponentCategory.TEXT:
        return 'Templates';
      case SubComponentCategory.INPUT:
        return 'Blocks';
      case SubComponentCategory.ANIMATIONS:
        return 'Animations';
      case SubComponentCategory.EFFECTS:
        return 'Effects';
    }
  }
}
