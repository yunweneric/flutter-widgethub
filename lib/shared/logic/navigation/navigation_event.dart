part of 'navigation_bloc.dart';

@immutable
class NavigationEvent {}

class NavigationEventUpdated extends NavigationEvent {
  final String route;

  NavigationEventUpdated({required this.route});
}
