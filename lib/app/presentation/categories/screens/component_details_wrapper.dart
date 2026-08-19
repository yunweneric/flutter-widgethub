/// Wrapper screen for displaying component details.
///
/// shadcn docs-style component page: title + lead description, platform
/// badges, live preview / code tabs, setup instructions and resources,
/// finished with previous/next pagination cards.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/presentation/categories/widget/component_details_footer.dart';
import 'package:flutterui/app/presentation/categories/widget/resource_section.dart';
import 'package:flutterui/app/presentation/categories/widget/supported_platforms.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/code_highlight.dart';
import 'package:flutterui/app/shared/presentation/widgets/code_preview.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/main_content.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:go_router/go_router.dart';

/// Component detail page.
class ComponentDetailsWrapper extends StatefulWidget {
  /// The component subcategory ID to display.
  final String id;

  /// Creates a component details wrapper.
  const ComponentDetailsWrapper({super.key, required this.id});

  @override
  State<ComponentDetailsWrapper> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ComponentDetailsWrapper> {
  final componentBloc = getIt.get<ComponentBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComponentBloc, ComponentState>(
      listener: (context, state) {
        if (state is UpdateActiveComponentSuccess) {
          final componentDetails = state.activeComponent;
          final link =
              "/components/${componentDetails.category.link()}/${componentDetails.subcategory.link()}/${componentDetails.id}/";
          context.go(link);
        }
      },
      builder: (context, state) {
        final component = state.allComponents
            .where((item) => item.id == widget.id)
            .firstOrNull;
        if (component != null) {
          final activeIndex = state.allComponents.indexOf(component);
          final canPrevious = activeIndex > 0;
          final canNext = activeIndex < state.allComponents.length - 1;
          return MainContent(
            children: [
              // Title + description.
              Text(
                LangUtil.trans(component.title),
                style: context.text.h1,
              ),
              const SizedBox(height: AppSpace.md),
              Text(
                LangUtil.trans(component.description),
                style: context.text.lead,
              ),
              const SizedBox(height: AppSpace.xl),

              // Platforms.
              SupportPlatformSection(component: component),

              // Live preview / code.
              CodePreview(component: component),
              const SizedBox(height: AppSpace.xxl),

              // Setup.
              Text(LangUtil.trans("Setup"), style: context.text.h3),
              const SizedBox(height: AppSpace.md),
              CodeHighlight(
                code: component.setup,
                title: 'setup',
              ),
              const SizedBox(height: AppSpace.xxl),

              // Resources.
              ResourceSection(component: component),

              // Pagination.
              ComponentDetailsFooter(
                canPrevious: canPrevious,
                canNext: canNext,
                context: context,
                activeIndex: activeIndex,
              ),
            ],
          );
        }
        return MainContent(
          children: [
            SizedBox(
              height: AppSizing.kHPercentage(context, 60),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    text: "'${widget.id}' ",
                    style: context.text.small,
                    children: <TextSpan>[
                      TextSpan(
                        text: LangUtil.trans('notFoundInCollections'),
                        style: context.text.muted,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
