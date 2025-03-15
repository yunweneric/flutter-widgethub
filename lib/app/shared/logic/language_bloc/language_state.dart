part of 'language_bloc.dart';

sealed class LanguageState extends Equatable {
  final Locale currentLocale;
  const LanguageState({required this.currentLocale});

  @override
  List<Object> get props => [currentLocale];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial({required super.currentLocale});
}

class UpdateLanguage extends LanguageState {
  const UpdateLanguage({required super.currentLocale});
}
