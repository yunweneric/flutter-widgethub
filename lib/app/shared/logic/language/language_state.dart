part of 'language_bloc.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

final class LanguageUpdated extends LanguageState {
  final Locale locale;
  LanguageUpdated(this.locale);
  List get props => [locale];
}
