part of 'language_bloc.dart';

/// Base class for language state.
///
/// Contains the current locale of the application.
sealed class LanguageState extends Equatable {
  /// The current locale.
  final Locale currentLocale;
  
  /// Creates a language state.
  const LanguageState({required this.currentLocale});

  @override
  List<Object> get props => [currentLocale];
}

/// Initial language state.
///
/// Represents the initial language state when the app starts.
class LanguageInitial extends LanguageState {
  /// Creates an initial language state.
  const LanguageInitial({required super.currentLocale});
}

/// Updated language state.
///
/// Represents a language state after a language change has been applied.
class UpdateLanguage extends LanguageState {
  /// Creates an updated language state.
  const UpdateLanguage({required super.currentLocale});
}
