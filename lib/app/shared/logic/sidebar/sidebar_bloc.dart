import 'package:bloc/bloc.dart';

part 'sidebar_event.dart';
part 'sidebar_state.dart';

class SidebarBloc extends Bloc<SidebarEvent, SidebarState> {
  SidebarBloc() : super(SidebarInitial(isOpen: false)) {
    on<UpdateSideBarEvent>((event, emit) {
      emit(SidebarUpdateStatus(isOpen: event.newStatus));
    });
  }
}
