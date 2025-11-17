// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../shared.dart';

/// A search bar component for property search with filter button.
///
/// API Reference:
/// - [onTap]: Callback when search bar is tapped
/// - [onFilterTap]: Callback when filter button is tapped
///
/// Usage:
/// ```dart
/// AirbnbSearchBar(
///   onTap: () {},
///   onFilterTap: () {},
/// )
/// ```
class AirbnbSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;

  const AirbnbSearchBar({
    super.key,
    this.onTap,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AirbnbConstants.radiusXXL),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AirbnbConstants.paddingL,
          vertical: AirbnbConstants.paddingM,
        ),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(AirbnbConstants.radiusXXL),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.string(
              AirbnbIconManager.search,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                theme.primaryColorDark,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: AirbnbConstants.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Where to?', style: textTheme.displaySmall),
                  Text(
                    'Anywhere • Any week • Add guests',
                    style: textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AirbnbConstants.paddingM),
            GestureDetector(
              onTap: onFilterTap,
              child: Container(
                padding: const EdgeInsets.all(AirbnbConstants.paddingS),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.primaryColorDark),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.string(
                  AirbnbIconManager.filter,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    theme.primaryColorDark,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
