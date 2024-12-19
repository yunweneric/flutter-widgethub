part of 'language_bloc.dart';

@immutable
sealed class LanguageEvent {}

class UpdateLanguageEvent extends LanguageEvent{
  final String languageCode;
  UpdateLanguageEvent(
    this.languageCode
  );
}
