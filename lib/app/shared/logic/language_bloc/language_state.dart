part of 'language_bloc.dart';

/// Language state containing the current locale.
class LanguageState extends Equatable {
  /// The current locale.
  final Locale currentLocale;

  /// Creates a language state.
  const LanguageState({required this.currentLocale});

  /// Creates an initial language state with default locale.
  const LanguageState.initial() : currentLocale = const Locale('en', 'US');

  /// Creates a language state with a specific locale.
  const LanguageState.updated(this.currentLocale);

  @override
  List<Object> get props => [currentLocale];
}
