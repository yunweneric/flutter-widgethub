/// Navigation state management BLoC.
///
/// Manages the current route state and tracks navigation changes
/// throughout the application.
import 'package:bloc/bloc.dart';
import 'package:flutterui/app/core/routes/route_names.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

/// BLoC for managing navigation state.
///
/// Tracks the current route and handles route update events.
/// Initializes with the home route as the default.
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  /// Creates a navigation bloc with home route as initial state.
  NavigationBloc() : super(NavigationInitial(currentRoute: RouteNames.home)) {
    on<NavigationEventUpdated>((event, emit) {
      emit(NavigationUpdated(currentRoute: event.route));
    });
  }
}
