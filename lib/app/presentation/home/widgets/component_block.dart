import 'package:flutter/material.dart';
import 'package:flutterui/app/presentation/home/model/component_block_model.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';

class ComponentBlock extends StatefulWidget {
  final AppCategoryGroupModel item;
  final bool isActive;

  const ComponentBlock({super.key, required this.isActive, required this.item});

  @override
  State<ComponentBlock> createState() => _ComponentBlockState();
}

class _ComponentBlockState extends State<ComponentBlock> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: ValueKey(widget.isActive),
      duration: const Duration(milliseconds: 200),
      tween: Tween<double>(begin: 1, end: 0),
      child: Container(
        // color: Colors.teal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.category.describe(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            AppSizing.kh10Spacer(),
            Text(
              widget.item.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      builder: (context, value, child) {
        return SizedBox(
          width: AppSizing.kWPercentage(context, 20),
          child: Column(
            children: [
              Divider(
                endIndent: value * AppSizing.kWPercentage(context, 20),
                color: widget.isActive
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).scaffoldBackgroundColor,
              ),
              AppSizing.kh10Spacer(),
              child!,
            ],
          ),
        );
      },
    );
  }
}
