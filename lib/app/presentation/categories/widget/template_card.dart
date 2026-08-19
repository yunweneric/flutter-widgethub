import 'package:flutter/material.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/shared.dart';
import 'package:go_router/go_router.dart';

/// Template screen card: bordered preview canvas with the live template.
class TemplateCard extends StatefulWidget {
  final Component component;
  final int index;

  /// Width of the card; falls back to a viewport-based width.
  final double? width;

  const TemplateCard(
      {super.key, required this.component, required this.index, this.width});

  @override
  State<TemplateCard> createState() => _TemplateCardState();
}

final componentBloc = getIt.get<ComponentBloc>();

class _TemplateCardState extends State<TemplateCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final componentDetails = widget.component.codeComponents[widget.index];
    final double cardWidth = widget.width ??
        AppSizing.kWPercentage(
            context, AppSizing.isMobile(context) ? 100 : 35);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          componentBloc
              .add(UpdateActiveComponentEvent(newComponent: widget.component));
          final link =
              "/components/${widget.component.category.link()}/${widget.component.subcategory.link()}/${widget.component.id}/${widget.index}";
          context.go(link);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(AppSpace.xl),
          width: cardWidth,
          height: AppSizing.isMobile(context)
              ? AppSizing.kWPercentage(context, 80)
              : cardWidth * 0.75,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: tokens.active.withValues(alpha: 0.4),
            border: Border.all(
              color: _hovered ? tokens.accent : tokens.border,
            ),
            borderRadius: AppRadii.lgAll,
          ),
          child: AnimatedScale(
            scale: _hovered ? 1 : 0.96,
            duration: const Duration(milliseconds: 200),
            child: AppDeviceFrame(
              child: componentDetails.widget,
            ),
          ),
        ),
      ),
    );
  }
}
