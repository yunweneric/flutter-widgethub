/// shadcn-style skeleton (loading placeholder) primitive.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';

/// Pulsing muted block used while content loads.
class AppSkeleton extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const AppSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return FadeTransition(
      opacity: Tween<double>(begin: 1.0, end: 0.5).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: tokens.active,
          borderRadius: widget.borderRadius ?? AppRadii.smAll,
        ),
      ),
    );
  }
}
