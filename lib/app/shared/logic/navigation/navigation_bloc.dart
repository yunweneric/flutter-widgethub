import 'package:bloc/bloc.dart';
import 'package:flutterui/app/core/routes/route_names.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial(currentRoute: RouteNames.home)) {
    on<NavigationEventUpdated>((event, emit) {
      emit(NavigationUpdated(currentRoute: event.route));
    });
  }
}
