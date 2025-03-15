part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class UpdateAppLanguageEvent extends LanguageEvent {
  final BuildContext context;
  final Locale newLocale;

  const UpdateAppLanguageEvent({required this.context, required this.newLocale});
}
