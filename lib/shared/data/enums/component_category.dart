enum ComponentCategory {
  TEMPLATES,
  BLOCKS,
  EFFECTS,
  ANIMATIONS;

  String describe() {
    switch (this) {
      case ComponentCategory.TEMPLATES:
        return 'Templates';
      case ComponentCategory.BLOCKS:
        return 'Blocks';
      case ComponentCategory.ANIMATIONS:
        return 'Animations';
      case ComponentCategory.EFFECTS:
        return 'Effects';
    }
  }
}
