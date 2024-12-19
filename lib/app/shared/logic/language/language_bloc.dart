import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<UpdateLanguageEvent>((event, emit) {
        
      emit(LanguageUpdated(event.languageCode));

      // TODO: implement event handler
    });
  }
}
