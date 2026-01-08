part of 'navigation_bloc.dart';

/// Base class for navigation-related events.
@immutable
class NavigationEvent {}

/// Event to update the current navigation route.
///
/// [route] The new route path to navigate to.
class NavigationEventUpdated extends NavigationEvent {
  /// The route path.
  final String route;

  /// Creates a navigation event updated.
  NavigationEventUpdated({required this.route});
}
