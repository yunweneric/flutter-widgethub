import 'package:flutter/material.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_icon_button.dart';
import 'package:flutterui/app/shared/presentation/widgets/github_icon_with_stars.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

/// Site footer: hairline top border, muted credit line and quick actions.
class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool isMobile = AppSizing.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: tokens.border)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppSpace.lg : AppSpace.xl,
              vertical: AppSpace.xl,
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              runSpacing: AppSpace.lg,
              children: [
                SizedBox(
                  width:
                      AppSizing.kWPercentage(context, isMobile ? 100 : 50),
                  child: Text(
                    LangUtil.trans("homeFooter", args: {
                      "year": DateTime.now().year.toString(),
                      "community": "Flutter Community",
                    }),
                    style: AppTypography.sans(
                      color: tokens.mutedForeground,
                      fontSize: 13,
                      height: 1.5,
                    ),
                    textAlign:
                        isMobile ? TextAlign.center : TextAlign.left,
                  ),
                ),
                SizedBox(
                  width:
                      AppSizing.kWPercentage(context, isMobile ? 100 : 30),
                  child: Row(
                    mainAxisAlignment: isMobile
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const GitHubIconWithStars(
                        owner: 'yunweneric',
                        repo: 'flutter-widgethub',
                        url:
                            'https://github.com/yunweneric/flutter-widgethub/',
                      ),
                      const SizedBox(width: AppSpace.sm),
                      Builder(
                        builder: (context) {
                          final theme = getIt.get<ThemeBloc>();
                          final isDark = Theme.of(context).brightness ==
                              Brightness.dark;
                          return AppIconButton(
                            onPressed: () => theme.add(
                              ChangeTheme(
                                  themeMode: isDark
                                      ? ThemeMode.light
                                      : ThemeMode.dark),
                            ),
                            child: AppIcon(
                              icon: isDark ? AppIcons.moon : AppIcons.sun,
                              size: 16,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
