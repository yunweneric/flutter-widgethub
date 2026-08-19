import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';

/// Sidebar navigation row (shadcn docs style).
///
/// 32px tall rounded row: muted text, accent surface on hover, and
/// accent surface + foreground text when active.
class SideBarItem extends StatefulWidget {
  final String title;
  final bool isActive;
  final String? link;
  final void Function()? onPressed;
  const SideBarItem(
      {super.key,
      required this.title,
      this.onPressed,
      this.link,
      required this.isActive});

  @override
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool emphasized = widget.isActive || _hovered;

    final name = LangUtil.trans("SubComponentCategoryEnum.${widget.title}");
    final formatted = name[0].toUpperCase() +
        name.split("_").join(" ").substring(1).toLowerCase();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: 32,
          margin: const EdgeInsets.only(bottom: 2),
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.md),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: widget.isActive
                ? tokens.accent
                : _hovered
                    ? tokens.accent.withValues(alpha: 0.6)
                    : Colors.transparent,
            borderRadius: AppRadii.smAll,
          ),
          child: Text(
            formatted,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.sans(
              color: emphasized ? tokens.foreground : tokens.mutedForeground,
              fontSize: 14,
              fontWeight:
                  widget.isActive ? FontWeight.w500 : FontWeight.w400,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
