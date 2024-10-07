import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/code_highlight.dart';
import 'package:flutterui/app/shared/presentation/widgets/code_preview.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/main_content.dart';
import 'package:go_router/go_router.dart';

class ComponentDetailsWrapper extends StatefulWidget {
  final String id;
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
          final link = "/components/${componentDetails.category.link()}/${componentDetails.subcategory.link()}/${componentDetails.id}/";
          context.go(link);
        }
      },
      builder: (context, state) {
        final component = state.allComponents.where((item) => item.id == widget.id).firstOrNull;
        if (component != null) {
          final activeIndex = state.allComponents.indexOf(component);
          final canPrevious = activeIndex > 0;
          final canNext = activeIndex < state.allComponents.length - 1;
          return MainContent(
            children: [
              Text(component.title, style: Theme.of(context).textTheme.displayLarge),
              AppSizing.kh10Spacer(),
              Text(component.description, style: Theme.of(context).textTheme.bodyMedium),
              AppSizing.kh20Spacer(),
              Text("Setup", style: Theme.of(context).textTheme.displayMedium),
              AppSizing.kh10Spacer(),
              AppSizing.kh10Spacer(),
              CodeHighlight(code: component.setup),
              AppSizing.kh20Spacer(),
              AppSizing.kh10Spacer(),
              supportPlatformSection(component, context),
              resourcesSection(component),
              CodePreview(component: component),
              AppSizing.kh20Spacer(),
              componentFooter(canPrevious, canNext, context, state, activeIndex),
            ],
          );
        }
        return MainContent(
          children: [
            SizedBox(
              height: AppSizing.kHPercentage(context, 60),
              child: Center(
                  child: RichText(
                text: TextSpan(
                  text: "'${widget.id}' ",
                  style: DefaultTextStyle.of(context).style.copyWith(color: Theme.of(context).primaryColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'not found in collections!',
                      style: TextStyle(color: Theme.of(context).primaryColorDark),
                    ),
                  ],
                ),
              )),
            ),
          ],
        );
      },
    );
  }

  Row componentFooter(
    bool canPrevious,
    bool canNext,
    BuildContext context,
    ComponentState state,
    int activeIndex,
  ) {
    return Row(
      mainAxisAlignment: canPrevious && canNext
          ? MainAxisAlignment.spaceBetween
          : canNext
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
      children: [
        if (canPrevious)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  componentBloc.add(FindNextComponentBloc(isNext: false));
                },
                label: Text(
                  "Previous",
                  style: TextStyle(color: Theme.of(context).highlightColor),
                ),
                icon: const AppIcon(icon: AppIcons.back),
              ),
              AppSizing.kh10Spacer(),
              Text(state.allComponents[activeIndex - 1].title, style: Theme.of(context).textTheme.displayMedium),
            ],
          ),
        if (canNext)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed: () {
                  componentBloc.add(FindNextComponentBloc(isNext: true));
                },
                label: Text(
                  "Next",
                  style: TextStyle(color: Theme.of(context).highlightColor),
                ),
                icon: const AppIcon(
                  icon: AppIcons.next,
                ),
              ),
              AppSizing.kh10Spacer(),
              Text(state.allComponents[activeIndex + 1].title, style: Theme.of(context).textTheme.displayMedium),
            ],
          )
      ],
    );
  }

  Column supportPlatformSection(Component component, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Support on",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        AppSizing.kh10Spacer(),
        Row(
          children: [
            ...component.supportedPlatforms.map((item) {
              bool hasHovered = false;
              return StatefulBuilder(builder: (context, setState) {
                return InkWell(
                  highlightColor: Theme.of(context).scaffoldBackgroundColor,
                  splashColor: Theme.of(context).scaffoldBackgroundColor,
                  hoverColor: Theme.of(context).scaffoldBackgroundColor,
                  onTap: () {},
                  onHover: (val) {
                    setState(() => hasHovered = val);
                  },
                  child: AnimatedScale(
                    scale: hasHovered ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: AppSizing.radiusMd(),
                      ),
                      child: Image.asset(
                        "assets/images/${item.describe()}.png",
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                );
              });
            })
          ],
        ),
        AppSizing.kh20Spacer(),
        AppSizing.kh10Spacer(),
      ],
    );
  }

  Widget resourcesSection(Component component) {
    if (component.assetLink == null && component.gitHubLink == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Resources",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        AppSizing.khSpacer(5),
        if (component.gitHubLink != null)
          rowItem(
            onTap: () => UtilHelper.openUrl(component.gitHubLink!),
            leading: AppIcons.github,
            title: "Open Github Repository",
          ),
        if (component.assetLink != null)
          rowItem(
            onTap: () => UtilHelper.openUrl(component.assetLink!),
            leading: AppIcons.download,
            title: "Download assets",
          ),
        AppSizing.kh20Spacer(),
        AppSizing.kh10Spacer(),
      ],
    );
  }

  Widget rowItem({required String leading, required String title, required VoidCallback onTap}) {
    bool isHovered = false;
    return StatefulBuilder(builder: (context, setState) {
      return InkWell(
        highlightColor: Theme.of(context).scaffoldBackgroundColor,
        splashColor: Theme.of(context).scaffoldBackgroundColor,
        hoverColor: Theme.of(context).scaffoldBackgroundColor,
        onTap: onTap,
        onHover: (val) {
          setState(() => isHovered = val);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: AnimatedScale(
            alignment: Alignment.centerLeft,
            duration: const Duration(milliseconds: 300),
            scale: isHovered ? 1.05 : 1.0,
            child: Row(
              children: [
                AppIcon(icon: leading, color: isHovered ? Theme.of(context).primaryColor : null),
                AppSizing.kwSpacer(5),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: isHovered ? Theme.of(context).primaryColor : null),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
