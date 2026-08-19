import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_motion.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';

/// Sidebar navigation row (LingoDesk dashboard style).
///
/// 36px rounded row: muted text, `active` wash on hover; the selected row
/// gets the tinted brand fill, brand ink and a small accent bar on the
/// left edge.
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

    final name = LangUtil.trans("SubComponentCategoryEnum.${widget.title}");
    final formatted = name[0].toUpperCase() +
        name.split("_").join(" ").substring(1).toLowerCase();

    final Color fg = widget.isActive
        ? tokens.onBrandFill
        : _hovered
            ? tokens.foreground
            : tokens.muted;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: AppMotion.fast,
          height: 36,
          margin: const EdgeInsets.only(bottom: 2),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: widget.isActive
                ? tokens.brandFill
                : _hovered
                    ? tokens.active
                    : Colors.transparent,
            borderRadius: AppRadii.smAll,
          ),
          child: Row(
            children: [
              // Accent bar on the selected row.
              AnimatedContainer(
                duration: AppMotion.fast,
                width: 3,
                height: 20,
                decoration: BoxDecoration(
                  color: widget.isActive ? tokens.accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: AppSpace.md - 3),
              Expanded(
                child: Text(
                  formatted,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.sans(
                    color: fg,
                    fontSize: 14,
                    fontWeight:
                        widget.isActive ? FontWeight.w700 : FontWeight.w500,
                    height: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
