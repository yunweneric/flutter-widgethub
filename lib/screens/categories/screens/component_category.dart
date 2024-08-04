import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/screens/categories/widget/category_card.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/screens/categories/widget/component_layout.dart';

@RoutePage()
class ComponentCategoryScreen extends StatefulWidget {
  const ComponentCategoryScreen({super.key});

  @override
  State<ComponentCategoryScreen> createState() => _ComponentCategoryScreenState();
}

class _ComponentCategoryScreenState extends State<ComponentCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        spacing: AppSizing.kWPercentage(context, 5),
        runSpacing: AppSizing.kWPercentage(context, 5),
        children: [
          ...[1, 2, 3, 4, 5, 6, 6].map(
            (item) {
              return CategoryCard();
            },
          )
        ],
      ),
    );
  }
}
