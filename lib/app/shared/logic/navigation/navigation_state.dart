part of 'navigation_bloc.dart';

class NavigationState {
  final String currentRoute;

  NavigationState({required this.currentRoute});
}

class NavigationInitial extends NavigationState {
  NavigationInitial({required super.currentRoute});
}

class NavigationUpdated extends NavigationState {
  NavigationUpdated({required super.currentRoute});
}
