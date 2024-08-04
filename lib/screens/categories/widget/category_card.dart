import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.w),
      width: AppSizing.kWPercentage(context, 35),
      height: AppSizing.kWPercentage(context, 35),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: AppSizing.radiusMd(),
      ),
      child: Column(
        children: [
          Image.network(
            "https://ui.aceternity.com/_next/image?url=https%3A%2F%2Fassets.aceternity.com%2Fmacbook-scroll.png&w=1920&q=75",
          )
        ],
      ),
    );
  }
}
