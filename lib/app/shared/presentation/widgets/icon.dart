import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// SVG asset icon with theme-aware default color.
class AppIcon extends StatelessWidget {
  final String icon;
  final double? size;
  final Color? color;
  const AppIcon({super.key, required this.icon, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    final Color resolved = color ??
        IconTheme.of(context).color ??
        Theme.of(context).colorScheme.onSurfaceVariant;
    return SvgPicture.asset(
      icon,
      width: size ?? 18,
      height: size ?? 18,
      colorFilter: ColorFilter.mode(resolved, BlendMode.srcIn),
      placeholderBuilder: (context) {
        return const Center(
          child: SizedBox(
            width: 10,
            height: 10,
            child: CircularProgressIndicator(strokeWidth: 1),
          ),
        );
      },
    );
  }
}
