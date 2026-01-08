part of 'navigation_bloc.dart';

/// Base class for navigation state.
///
/// Contains the current route of the application.
class NavigationState {
  /// The current route path.
  final String currentRoute;

  /// Creates a navigation state.
  NavigationState({required this.currentRoute});
}

/// Initial navigation state.
///
/// Represents the initial navigation state when the app starts.
class NavigationInitial extends NavigationState {
  /// Creates an initial navigation state.
  NavigationInitial({required super.currentRoute});
}

/// Updated navigation state.
///
/// Represents a navigation state after a route change has occurred.
class NavigationUpdated extends NavigationState {
  /// Creates an updated navigation state.
  NavigationUpdated({required super.currentRoute});
}
