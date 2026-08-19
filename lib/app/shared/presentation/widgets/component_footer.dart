import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/project_links.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/github_icon_with_stars.dart';
import 'package:flutterui/app/shared/presentation/widgets/ui/app_text_link.dart';

/// Colophon for docs pages.
///
/// Sits inside the content column and lays itself out from the width it
/// is given, so the credit line stays flush with the prose above it and
/// the GitHub button lands on the column's right edge — no viewport
/// percentages, which drift out of the column on wide screens.
class ComponentFooter extends StatelessWidget {
  const ComponentFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool isMobile = AppSizing.isMobile(context);

    final credit = Text(
      LangUtil.trans("componentFooter"),
      style: AppTypography.sans(
        color: tokens.mutedForeground,
        fontSize: 13,
        height: 1.5,
      ),
      textAlign: isMobile ? TextAlign.center : TextAlign.left,
    );

    final links = Wrap(
      spacing: AppSpace.lg,
      runSpacing: AppSpace.sm,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: [
        AppTextLink(
          label: LangUtil.trans("footerContributing"),
          url: ProjectLinks.contributing,
        ),
        AppTextLink(
          label: LangUtil.trans("footerReportIssue"),
          url: ProjectLinks.newIssue,
        ),
        AppTextLink(
          label: LangUtil.trans("footerDiscussions"),
          url: ProjectLinks.discussions,
        ),
        AppTextLink(
          label: LangUtil.trans("footerLicense"),
          url: ProjectLinks.license,
        ),
      ],
    );

    const stars = GitHubIconWithStars(
      owner: ProjectLinks.owner,
      repo: ProjectLinks.repoName,
      url: ProjectLinks.repo,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.xl),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                links,
                const SizedBox(height: AppSpace.lg),
                credit,
                const SizedBox(height: AppSpace.lg),
                stars,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      links,
                      const SizedBox(height: AppSpace.sm),
                      credit,
                    ],
                  ),
                ),
                const SizedBox(width: AppSpace.lg),
                stars,
              ],
            ),
    );
  }
}
