part of 'sidebar_bloc.dart';

/// Base class for sidebar-related events.
class SidebarEvent {}

/// Event to update the sidebar open/closed status.
///
/// [newStatus] The new open/closed status (true = open, false = closed).
class UpdateSideBarEvent extends SidebarEvent {
  /// The new sidebar status.
  final bool newStatus;

  /// Creates an update sidebar event.
  UpdateSideBarEvent({required this.newStatus});
}
