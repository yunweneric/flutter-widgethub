import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/screens/routes/app_router.gr.dart';
import 'package:flutterui/components/export/data.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';

class CategoryCard extends StatefulWidget {
  final Component component;
  const CategoryCard({super.key, required this.component});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizing.kWPercentage(context, 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(30.w),
            width: AppSizing.kWPercentage(context, 35),
            height: AppSizing.kWPercentage(context, 25),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: AppSizing.radiusMd(),
            ),
            child: InkWell(
              onTap: () {
                context.router.push(ComponentDetailsRoute(component: widget.component));
              },
              mouseCursor: WidgetStateMouseCursor.clickable,
              onHover: (status) {
                print(['status', status]);
                setState(() {
                  isHovered = status;
                });
              },
              child: AnimatedScale(
                scale: isHovered ? 1.0 : 0.8,
                duration: Duration(milliseconds: 400),
                child: Center(child: widget.component.widget),
              ),
            ),
          ),
          Container(
            padding: AppSizing.kpadding(0, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.component.title,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                AppSizing.kh10Spacer(),
                Text(
                  widget.component.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
