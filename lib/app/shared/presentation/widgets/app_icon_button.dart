import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/sizing.dart';

/// Reusable icon button widget with consistent styling.
///
/// Provides a uniform square icon button with gray background and padding
/// that can be used throughout the application.
class AppIconButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const AppIconButton({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: backgroundColor ?? Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: AppSizing.radiusSm(),
        ),
      ),
      icon: child,
    );
  }
}
