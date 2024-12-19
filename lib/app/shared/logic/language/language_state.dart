part of 'language_bloc.dart';

@immutable
sealed class LanguageState {
}

final class LanguageInitial extends LanguageState {}

final class LanguageUpdated extends LanguageState{
  final String language;
  LanguageUpdated(this.language);
    List get props => [language];
}
