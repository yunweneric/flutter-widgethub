import 'package:bloc/bloc.dart';
import 'package:flutterui/components/ui/export/data.dart';

part 'component_event.dart';
part 'component_state.dart';

class ComponentBloc extends Bloc<ComponentEvent, ComponentState> {
  ComponentBloc() : super(ComponentInitial(activeComponent: AllComponents.widgets.first, allComponents: [])) {
    on<GetAllComponentsEvent>((event, emit) {
      emit(FetchComponents(activeComponent: state.activeComponent, allComponents: AllComponents.widgets));
    });
    on<UpdateActiveComponentEvent>((event, emit) {
      emit(UpdateActiveComponentSuccess(
        activeComponent: event.newComponent,
        allComponents: state.allComponents,
      ));
    });
    on<FindNextComponentBloc>((event, emit) {
      final allComponents = AllComponents.widgets;
      final activeIndex = allComponents.indexWhere((component) => component.title == state.activeComponent.title);

      if (activeIndex == -1) {
        emit(UpdateActiveComponentSuccess(
          activeComponent: allComponents.first,
          allComponents: state.allComponents,
        ));
        return;
      }
      if (event.isNext && activeIndex < allComponents.length - 1) {
        emit(UpdateActiveComponentSuccess(
          activeComponent: allComponents[activeIndex + 1],
          allComponents: state.allComponents,
        ));
        return;
      }
      if (!event.isNext && activeIndex > 0) {
        emit(UpdateActiveComponentSuccess(
          activeComponent: allComponents[activeIndex - 1],
          allComponents: state.allComponents,
        ));
        return;
      }
    });
  }
}
