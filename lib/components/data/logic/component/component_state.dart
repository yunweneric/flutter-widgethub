part of 'component_bloc.dart';

class ComponentState {
  final Component activeComponent;
  final List<Component> allComponents;
  final AppCategory? activeCategory;

  ComponentState({
    required this.activeComponent,
    required this.allComponents,
    this.activeCategory,
  });
}

class FetchComponents extends ComponentState {
  FetchComponents({
    required super.activeComponent,
    required super.allComponents,
    super.activeCategory,
  });
}

class ComponentInitial extends ComponentState {
  ComponentInitial({
    required super.activeComponent,
    required super.allComponents,
    super.activeCategory,
  });
}

class UpdateActiveComponentSuccess extends ComponentState {
  UpdateActiveComponentSuccess({
    required super.activeComponent,
    required super.allComponents,
    super.activeCategory,
  });
}

class UpdateActiveCategorySuccess extends ComponentState {
  UpdateActiveCategorySuccess({
    required super.activeComponent,
    required super.allComponents,
    required super.activeCategory,
  });
}
