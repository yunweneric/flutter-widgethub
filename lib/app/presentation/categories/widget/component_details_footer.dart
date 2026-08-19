import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:flutterui/app/shared/presentation/widgets/ui/app_card.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';

/// Previous / Next pagination cards at the bottom of a component page
/// (shadcn docs pagination style).
class ComponentDetailsFooter extends StatelessWidget {
  final bool canPrevious;
  final bool canNext;
  final BuildContext context;
  final int activeIndex;
  const ComponentDetailsFooter({
    super.key,
    required this.canPrevious,
    required this.canNext,
    required this.context,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    final componentBloc = getIt.get<ComponentBloc>();

    return BlocBuilder<ComponentBloc, ComponentState>(
      builder: (context, state) {
        final bool stack = AppSizing.isMobile(context);

        final Widget previous = canPrevious
            ? _PaginationCard(
                direction: _PaginationDirection.previous,
                label: LangUtil.trans("previous"),
                title:
                    LangUtil.trans(state.allComponents[activeIndex - 1].title),
                onTap: () => componentBloc
                    .add(FindNextComponentBlocEvent(isNext: false)),
              )
            : const SizedBox.shrink();

        final Widget next = canNext
            ? _PaginationCard(
                direction: _PaginationDirection.next,
                label: LangUtil.trans("next"),
                title:
                    LangUtil.trans(state.allComponents[activeIndex + 1].title),
                onTap: () =>
                    componentBloc.add(FindNextComponentBlocEvent(isNext: true)),
              )
            : const SizedBox.shrink();

        if (stack) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (canPrevious) previous,
              if (canPrevious && canNext)
                const SizedBox(height: AppSpace.md),
              if (canNext) next,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: previous),
            const SizedBox(width: AppSpace.lg),
            Expanded(child: next),
          ],
        );
      },
    );
  }
}

enum _PaginationDirection { previous, next }

class _PaginationCard extends StatelessWidget {
  final _PaginationDirection direction;
  final String label;
  final String title;
  final VoidCallback onTap;

  const _PaginationCard({
    required this.direction,
    required this.label,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool isNext = direction == _PaginationDirection.next;

    return AppCard(
      onTap: onTap,
      hoverable: true,
      padding: const EdgeInsets.all(AppSpace.lg),
      child: Column(
        crossAxisAlignment:
            isNext ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isNext) ...[
                AppIcon(
                    icon: AppIcons.back,
                    size: 12,
                    color: tokens.mutedForeground),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: AppTypography.sans(
                  color: tokens.mutedForeground,
                  fontSize: 12,
                  height: 1.0,
                ),
              ),
              if (isNext) ...[
                const SizedBox(width: 6),
                AppIcon(
                    icon: AppIcons.next,
                    size: 12,
                    color: tokens.mutedForeground),
              ],
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.sans(
              color: tokens.foreground,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
