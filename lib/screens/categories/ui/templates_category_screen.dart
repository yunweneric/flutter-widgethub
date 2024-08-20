// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/components/ui/export/data.dart';
import 'package:flutterui/screens/categories/ui/component_details_wrapper.dart';

// @RoutePage()
class TemplatesCategoryScreen extends StatefulWidget {
  final Component component;
  const TemplatesCategoryScreen({super.key, required this.component});

  @override
  State<TemplatesCategoryScreen> createState() => _TemplatesCategoryScreenState();
}

class _TemplatesCategoryScreenState extends State<TemplatesCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ComponentDetailsWrapper(component: widget.component);
  }
}
