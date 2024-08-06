part of 'component_bloc.dart';

class ComponentEvent {}

class UpdateActiveComponentEvent extends ComponentEvent {
  final Component newComponent;

  UpdateActiveComponentEvent({required this.newComponent});
}

class GetAllComponentsEvent extends ComponentEvent {}

class FindNextComponentBloc extends ComponentEvent {
  final bool isNext;

  FindNextComponentBloc({required this.isNext});
}
