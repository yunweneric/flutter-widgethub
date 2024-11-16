part of 'component_bloc.dart';

class ComponentEvent {}

class UpdateActiveComponentEvent extends ComponentEvent {
  final Component newComponent;

  UpdateActiveComponentEvent({required this.newComponent});
}

class GetAllComponentsEvent extends ComponentEvent {}

class FindNextComponentBlocEvent extends ComponentEvent {
  final bool isNext;

  FindNextComponentBlocEvent({required this.isNext});
}

class UpdateActiveCategoryEvent extends ComponentEvent {
  final AppCategoryModel category;
  UpdateActiveCategoryEvent({required this.category});
}
