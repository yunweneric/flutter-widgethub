import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/shared.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:go_router/go_router.dart';

/// Component card in the browse grid: bordered preview canvas with the
/// live widget, then title + muted description (shadcn card style).
class CategoryCard extends StatefulWidget {
  final Component component;

  /// Width of the card; falls back to a viewport-based width.
  final double? width;

  const CategoryCard({super.key, required this.component, this.width});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  final componentBloc = getIt.get<ComponentBloc>();
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final Component componentDetails = widget.component;
    final double cardWidth = widget.width ??
        AppSizing.kWPercentage(
            context, AppSizing.isMobile(context) ? 100 : 35);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          componentBloc.add(
              UpdateActiveComponentEvent(newComponent: componentDetails));
          final link =
              "/components/${componentDetails.category.link()}/${componentDetails.subcategory.link()}/${componentDetails.id}/";
          context.go(link);
        },
        child: SizedBox(
          width: cardWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Preview canvas.
              Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.all(AppSpace.xl),
                    width: cardWidth,
                    height: AppSizing.isMobile(context)
                        ? AppSizing.kWPercentage(context, 80)
                        : cardWidth * 0.75,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: tokens.muted.withValues(alpha: 0.4),
                      border: Border.all(
                        color: _hovered
                            ? tokens.mutedForeground.withValues(alpha: 0.5)
                            : tokens.border,
                      ),
                      borderRadius: AppRadii.lgAll,
                    ),
                    child: AnimatedScale(
                      scale: _hovered ? 1 : 0.96,
                      duration: const Duration(milliseconds: 200),
                      child: AppDeviceFrame(
                        child: componentDetails.codeComponents.first.widget,
                      ),
                    ),
                  ),
                  if (componentDetails.codeComponents.length > 1)
                    Positioned(
                      top: AppSpace.md,
                      right: AppSpace.md,
                      child: AppBadge(
                        label:
                            "${componentDetails.codeComponents.length} ${LangUtil.trans("components")}",
                      ),
                    ),
                ],
              ),

              // Meta.
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpace.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LangUtil.trans(componentDetails.title),
                      style: AppTypography.sans(
                        color: tokens.foreground,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: AppSpace.xs),
                    Text(
                      LangUtil.trans(componentDetails.description),
                      style: AppTypography.sans(
                        color: tokens.mutedForeground,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
