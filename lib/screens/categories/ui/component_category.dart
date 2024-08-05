import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/screens/categories/widget/category_card.dart';
import 'package:flutterui/components/export/data.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/screens/categories/widget/component_layout.dart';
import 'package:flutterui/shared/ui/widgets/layout/main_content.dart';

@RoutePage()
class ComponentCategoryScreen extends StatefulWidget {
  const ComponentCategoryScreen({super.key});

  @override
  State<ComponentCategoryScreen> createState() => _ComponentCategoryScreenState();
}

class _ComponentCategoryScreenState extends State<ComponentCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return MainContent(
      children: [
        Wrap(
          spacing: AppSizing.isTablet(context) ? AppSizing.kWPercentage(context, 2) : AppSizing.kWPercentage(context, 5),
          runSpacing: AppSizing.kWPercentage(context, 5),
          children: [
            ...AllComponents.widgets.map(
              (item) {
                return CategoryCard(component: item);
              },
            )
          ],
        ),
      ],
    );
  }
}
