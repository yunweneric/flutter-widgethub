import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:go_router/go_router.dart';

class CategoryCard extends StatefulWidget {
  final Component component;
  const CategoryCard({super.key, required this.component});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  final componentBloc = getIt.get<ComponentBloc>();
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    Component componentDetails = widget.component;
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(),
          width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(30.w),
                width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 35),
                height: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 80 : 25),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: AppSizing.radiusMd(),
                ),
                child: AnimatedScale(
                  scale: isHovered ? 1 : 0.95,
                  duration: const Duration(milliseconds: 200),
                  child: DeviceFrame(
                    screen: componentDetails.codeComponents.first.widget,
                    device: Devices.ios.iPhone13,
                  ),
                ),
              ),
              Container(
                padding: AppSizing.kpadding(0, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LangUtil.trans(componentDetails.title),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    AppSizing.kh10Spacer(),
                    Text(
                      LangUtil.trans(componentDetails.description),
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        InkWell(
          focusColor: Theme.of(context).scaffoldBackgroundColor,
          hoverColor: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: AppSizing.radiusMd(),
          onTap: () {
            componentBloc.add(UpdateActiveComponentEvent(newComponent: componentDetails));
            final link =
                "/components/${componentDetails.category.link()}/${componentDetails.subcategory.link()}/${componentDetails.id}/";
            context.go(link);
          },
          onHover: (status) {
            setState(() {
              isHovered = status;
            });
          },
          child: Container(
            width: AppSizing.kWPercentage(
              context,
              AppSizing.isMobile(context)
                  ? 45
                  : AppSizing.isTablet(context)
                      ? 30
                      : 35,
            ),
            decoration: BoxDecoration(
              borderRadius: AppSizing.radiusMd(),
            ),
            height: AppSizing.kWPercentage(context, 25),
          ),
        ),
        if (componentDetails.codeComponents.length > 1)
          Positioned(
            top: 10,
            right: 10,
            child: Chip(
              label: Text(
                "${componentDetails.codeComponents.length} ${LangUtil.trans("components")}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          )
      ],
    );
  }
}
