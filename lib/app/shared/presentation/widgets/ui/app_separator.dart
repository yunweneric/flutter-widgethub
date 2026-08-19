/// shadcn-style separator primitive.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';

/// 1px hairline divider, horizontal or vertical.
class AppSeparator extends StatelessWidget {
  final Axis axis;
  final double? length;
  final EdgeInsetsGeometry margin;

  const AppSeparator({
    super.key,
    this.axis = Axis.horizontal,
    this.length,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Container(
      margin: margin,
      width: axis == Axis.horizontal ? length : 1,
      height: axis == Axis.horizontal ? 1 : (length ?? 16),
      color: tokens.border,
    );
  }
}
