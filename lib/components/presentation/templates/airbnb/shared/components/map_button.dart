import 'package:flutter/material.dart';
import '../constants.dart';

class MapButton extends StatelessWidget {
  final VoidCallback? onTap;

  const MapButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AirbnbConstants.paddingL,
        vertical: AirbnbConstants.paddingM,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.onSurface,
          foregroundColor: colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AirbnbConstants.paddingM,
            horizontal: AirbnbConstants.paddingL,
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AirbnbConstants.mapIcon,
              size: 20,
            ),
            const SizedBox(width: AirbnbConstants.paddingS),
            Text(
              'Map',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.surface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
