import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/components/export/data.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/code_highlight.dart';
import 'package:flutterui/shared/ui/widgets/code_preview.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';
import 'package:flutterui/shared/ui/widgets/layout/main_content.dart';

@RoutePage()
class ComponentDetailsScreen extends StatefulWidget {
  final Component component;
  const ComponentDetailsScreen({super.key, required this.component});

  @override
  State<ComponentDetailsScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ComponentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MainContent(
      children: [
        Text(
          widget.component.title,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        AppSizing.kh10Spacer(),
        Text(
          widget.component.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        AppSizing.kh20Spacer(),
        Text(
          "Setup",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        AppSizing.kh10Spacer(),
        CodeHighlight(code: widget.component.setup),
        AppSizing.kh20Spacer(),
        CodePreview(component: widget.component),
        AppSizing.kh20Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  label: Text("Previous"),
                  icon: AppIcon(icon: AppIcons.back),
                ),
                AppSizing.kh10Spacer(),
                Text("Previous", style: Theme.of(context).textTheme.displayMedium),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  onPressed: () {},
                  label: Text("Next"),
                  icon: AppIcon(icon: AppIcons.next),
                ),
                AppSizing.kh10Spacer(),
                Text("Next", style: Theme.of(context).textTheme.displayMedium),
              ],
            )
          ],
        )
      ],
    );
  }
}
