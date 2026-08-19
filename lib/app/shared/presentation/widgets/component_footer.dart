import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/github_icon_with_stars.dart';

/// Footer for docs pages: muted credit line + GitHub stars.
class ComponentFooter extends StatelessWidget {
  const ComponentFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool isMobile = AppSizing.isMobile(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.xl),
      child: Wrap(
        runSpacing: AppSpace.lg,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.spaceBetween,
        alignment: WrapAlignment.spaceBetween,
        children: [
          SizedBox(
            width: AppSizing.kWPercentage(context, isMobile ? 100 : 35),
            child: Text(
              LangUtil.trans("componentFooter"),
              style: AppTypography.sans(
                color: tokens.mutedForeground,
                fontSize: 13,
                height: 1.5,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
          ),
          SizedBox(
            width: AppSizing.kWPercentage(context, isMobile ? 100 : 35),
            child: Row(
              mainAxisAlignment: isMobile
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: const [
                GitHubIconWithStars(
                  owner: 'yunweneric',
                  repo: 'flutter-widgethub',
                  url: 'https://github.com/yunweneric/flutter-widgethub/',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
