part of 'sidebar_bloc.dart';

class SidebarState {
  final bool isOpen;

  SidebarState({required this.isOpen});
}

class SidebarInitial extends SidebarState {
  SidebarInitial({required super.isOpen});
}

class SidebarUpdateStatus extends SidebarState {
  SidebarUpdateStatus({required super.isOpen});
}
