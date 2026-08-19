import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/language_bloc/language_bloc.dart';
import 'package:flutterui/app/shared/presentation/theme/app_motion.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_icon_button.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

/// Compact language switcher — ghost trigger with a popover menu.
class LanguageButton extends StatefulWidget {
  const LanguageButton({super.key});

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

List<Locale> languages = [
  const Locale("en", "US"),
  const Locale("fr", "FR"),
];

class _LanguageButtonState extends State<LanguageButton> {
  final languageBloc = getIt.get<LanguageBloc>();
  bool _hovered = false;

  void handleChangeLanguage(Locale? locale) {
    if (locale == null) return;
    languageBloc.add(UpdateAppLanguageEvent(newLocale: locale));
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        final current = state.currentLocale;
        return PopupMenuButton<Locale>(
          tooltip: '',
          offset: const Offset(0, 44),
          onSelected: handleChangeLanguage,
          itemBuilder: (context) => languages
              .map(
                (lang) => PopupMenuItem<Locale>(
                  value: lang,
                  height: 36,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/${lang.languageCode}.svg',
                        width: 16,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: AppSpace.sm),
                      Text(
                        lang.languageCode.toUpperCase(),
                        style: AppTypography.sans(
                          color: tokens.foreground,
                          fontSize: 13,
                          fontWeight: lang == current
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                      if (lang == current) ...[
                        const Spacer(),
                        AppIcon(
                          icon: AppIcons.check,
                          size: 14,
                          color: tokens.mutedForeground,
                        ),
                      ],
                    ],
                  ),
                ),
              )
              .toList(),
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: AppMotion.fast,
              curve: Curves.easeOut,
              height: AppActionSurface.size,
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.sm),
              alignment: Alignment.center,
              decoration:
                  AppActionSurface.decoration(tokens, hovered: _hovered),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    current.languageCode.toUpperCase(),
                    style: AppTypography.sans(
                      color: AppActionSurface.foreground(tokens,
                          hovered: _hovered),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(width: 2),
                  AppIcon(
                    icon: AppIcons.chevronDown,
                    size: 14,
                    color:
                        AppActionSurface.foreground(tokens, hovered: _hovered),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
