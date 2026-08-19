import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

/// External resource links for a component (GitHub repo, assets).
class ResourceSection extends StatelessWidget {
  final Component component;
  const ResourceSection({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    if (component.assetLink == null && component.gitHubLink == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangUtil.trans("resources"),
          style: context.text.h4,
        ),
        const SizedBox(height: AppSpace.md),
        if (component.gitHubLink != null)
          RowItem(
            onTap: () => UtilHelper.openUrl(component.gitHubLink!),
            leading: AppIcons.github,
            title: LangUtil.trans("openGithubRepository"),
          ),
        if (component.assetLink != null)
          RowItem(
            onTap: () => UtilHelper.openUrl(component.assetLink!),
            leading: AppIcons.download,
            title: LangUtil.trans("downloadAssets"),
          ),
        const SizedBox(height: AppSpace.xxl),
      ],
    );
  }
}

/// Hoverable resource link row.
class RowItem extends StatefulWidget {
  final AppIconData leading;
  final String title;
  final VoidCallback onTap;

  const RowItem({
    super.key,
    required this.leading,
    required this.title,
    required this.onTap,
  });

  @override
  State<RowItem> createState() => _RowItemState();
}

class _RowItemState extends State<RowItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final Color fg = _hovered ? tokens.accent : tokens.muted;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(icon: widget.leading, color: fg, size: 15),
              const SizedBox(width: AppSpace.sm),
              Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.sans(
                  color: fg,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ).copyWith(
                  decoration: _hovered ? TextDecoration.underline : null,
                  decorationColor: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
