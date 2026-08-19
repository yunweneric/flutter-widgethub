import 'package:flutter/material.dart';
import 'package:flutterui/app/presentation/home/model/component_block_model.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';

/// Category switcher entry in the landing "assets" section.
///
/// Active entry gets a foreground top rule and emphasized title.
class ComponentBlock extends StatefulWidget {
  final AppCategoryGroupModel item;
  final bool isActive;

  /// Measured column width; falls back to a viewport share when unset.
  final double? width;

  const ComponentBlock({
    super.key,
    required this.isActive,
    required this.item,
    this.width,
  });

  @override
  State<ComponentBlock> createState() => _ComponentBlockState();
}

class _ComponentBlockState extends State<ComponentBlock> {
  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return TweenAnimationBuilder(
      key: ValueKey(widget.isActive),
      duration: const Duration(milliseconds: 200),
      tween: Tween<double>(begin: 1, end: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.item.category.describe(),
            style: AppTypography.sans(
              color:
                  widget.isActive ? tokens.foreground : tokens.mutedForeground,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: AppSpace.sm),
          Text(
            LangUtil.trans(widget.item.description),
            style: AppTypography.sans(
              color: tokens.mutedForeground,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
      builder: (context, value, child) {
        final blockWidth = widget.width ?? AppSizing.kWPercentage(context, 20);
        return SizedBox(
          width: blockWidth,
          child: Column(
            children: [
              Divider(
                endIndent: value * blockWidth,
                thickness: 2,
                color: widget.isActive ? tokens.accent : tokens.border,
              ),
              const SizedBox(height: AppSpace.md),
              child!,
              const SizedBox(height: AppSpace.lg),
            ],
          ),
        );
      },
    );
  }
}
