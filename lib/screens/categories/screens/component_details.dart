import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/shared/data/components.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/code_highlighter.dart';
import 'package:flutterui/screens/categories/widget/component_layout.dart';

@RoutePage()
class ComponentDetailsScreen extends StatefulWidget {
  const ComponentDetailsScreen({super.key});

  @override
  State<ComponentDetailsScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ComponentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Title of the Page",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        AppSizing.kh10Spacer(),
        Text(
          "When designing a responsive website, breakpoints are crucial for ensuring that your layout adapts smoothly to various screen sizes. Here are common breakpoints used in web development, which you can adjust based on your specific design needs",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        AppSizing.kh20Spacer(),
        CodeHighlighter(component: AllComponents.widgets[0]),
      ],
    );
  }
}
