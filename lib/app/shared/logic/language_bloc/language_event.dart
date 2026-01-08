part of 'language_bloc.dart';

/// Base class for language-related events.
sealed class LanguageEvent extends Equatable {
  /// Creates a language event.
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

/// Event to update the application language.
///
/// [newLocale] The new locale to apply.
class UpdateAppLanguageEvent extends LanguageEvent {
  /// The new locale to apply.
  final Locale newLocale;

  /// Creates an update app language event.
  const UpdateAppLanguageEvent({required this.newLocale});

  @override
  List<Object> get props => [newLocale];
}
