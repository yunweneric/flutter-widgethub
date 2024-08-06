part of 'component_bloc.dart';

class ComponentState {
  final Component activeComponent;
  final List<Component> allComponents;

  ComponentState({required this.activeComponent, required this.allComponents});
}

class FetchComponents extends ComponentState {
  FetchComponents({required super.activeComponent, required super.allComponents});
}

class ComponentInitial extends ComponentState {
  ComponentInitial({required super.activeComponent, required super.allComponents});
}

class UpdateActiveComponentSuccess extends ComponentState {
  UpdateActiveComponentSuccess({required super.activeComponent, required super.allComponents});
}
