part of 'sidebar_bloc.dart';

class SidebarEvent {}

class UpdateSideBarEvent extends SidebarEvent {
  final bool newStatus;

  UpdateSideBarEvent({required this.newStatus});
}
