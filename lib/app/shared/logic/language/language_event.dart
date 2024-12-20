part of 'language_bloc.dart';

@immutable
sealed class LanguageEvent {}

class UpdateLanguageEvent extends LanguageEvent {
  final Locale locale;
  UpdateLanguageEvent(this.locale);
}
