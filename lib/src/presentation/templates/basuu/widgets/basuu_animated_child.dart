import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';

class BasuuAnimatedChild extends StatelessWidget {
  final Widget child;
  final double animation;
  final double offset;
  const BasuuAnimatedChild({super.key, required this.child, required this.animation, required this.offset});
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, offset * animation * AppSizing.kHPercentage(context, 10)),
      child: Opacity(
        opacity: 1 - animation,
        child: child,
      ),
    );
  }
}
