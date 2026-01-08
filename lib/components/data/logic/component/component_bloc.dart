/// Component state management BLoC.
///
/// Manages the state of components in the application including:
/// - Active component selection
/// - Component filtering by category
/// - Navigation between components
library;

import 'package:bloc/bloc.dart';
import 'package:flutterui/components/presentation/export/store.dart';
import 'package:flutterui/app/presentation/home/model/component_block_model.dart';
import 'package:flutterui/app/shared/data/models/component.dart';

part 'component_event.dart';
part 'component_state.dart';

/// BLoC for managing component state.
///
/// Handles component selection, filtering, and navigation.
/// Initializes with the first component from the registry as the active component.
class ComponentBloc extends Bloc<ComponentEvent, ComponentState> {
  /// Creates a component bloc with the first component as initial state.
  ComponentBloc()
      : super(ComponentInitial(
            activeComponent: AllComponents.widgets.first, allComponents: [])) {
    on<UpdateActiveCategoryEvent>((event, emit) {
      emit(UpdateActiveCategorySuccess(
        activeComponent: state.activeComponent,
        allComponents: AllComponents.widgets,
        activeCategory: event.category,
      ));
    });
    on<GetAllComponentsEvent>((event, emit) {
      emit(FetchComponents(
        activeComponent: state.activeComponent,
        allComponents: AllComponents.widgets,
        activeCategory: state.activeCategory,
      ));
    });
    on<UpdateActiveComponentEvent>((event, emit) {
      emit(UpdateActiveComponentSuccess(
        activeComponent: event.newComponent,
        allComponents: state.allComponents,
        activeCategory: state.activeCategory,
      ));
    });
    on<FindNextComponentBlocEvent>((event, emit) {
      final allComponents = AllComponents.widgets;
      final activeIndex = allComponents
          .indexWhere((component) => component.id == state.activeComponent.id);

      if (activeIndex == -1) {
        emit(UpdateActiveComponentSuccess(
          activeComponent: allComponents.first,
          allComponents: state.allComponents,
          activeCategory: state.activeCategory,
        ));
        return;
      }
      if (event.isNext && activeIndex < allComponents.length - 1) {
        emit(UpdateActiveComponentSuccess(
          activeComponent: allComponents[activeIndex + 1],
          allComponents: state.allComponents,
          activeCategory: state.activeCategory,
        ));
        return;
      }
      if (!event.isNext && activeIndex > 0) {
        emit(UpdateActiveComponentSuccess(
          activeComponent: allComponents[activeIndex - 1],
          allComponents: state.allComponents,
          activeCategory: state.activeCategory,
        ));
        return;
      }
    });
  }
}
