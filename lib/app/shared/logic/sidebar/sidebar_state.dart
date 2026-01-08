part of 'sidebar_bloc.dart';

/// Base class for sidebar state.
///
/// Contains the current open/closed state of the sidebar.
class SidebarState {
  /// Whether the sidebar is currently open.
  final bool isOpen;

  /// Creates a sidebar state.
  SidebarState({required this.isOpen});
}

/// Initial sidebar state.
///
/// Represents the initial sidebar state when the app starts.
class SidebarInitial extends SidebarState {
  /// Creates an initial sidebar state.
  SidebarInitial({required super.isOpen});
}

/// Updated sidebar state.
///
/// Represents a sidebar state after an open/close status change.
class SidebarUpdateStatus extends SidebarState {
  /// Creates an updated sidebar state.
  SidebarUpdateStatus({required super.isOpen});
}
