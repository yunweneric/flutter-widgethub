/// Sidebar state management BLoC.
///
/// Manages the open/closed state of the application sidebar navigation.
import 'package:bloc/bloc.dart';

part 'sidebar_event.dart';
part 'sidebar_state.dart';

/// BLoC for managing sidebar state.
///
/// Handles sidebar open/close state changes.
/// Initializes with sidebar closed by default.
class SidebarBloc extends Bloc<SidebarEvent, SidebarState> {
  /// Creates a sidebar bloc with closed state as initial.
  SidebarBloc() : super(SidebarInitial(isOpen: false)) {
    on<UpdateSideBarEvent>((event, emit) {
      emit(SidebarUpdateStatus(isOpen: event.newStatus));
    });
  }
}
