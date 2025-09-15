import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class HostInfoWidget extends StatelessWidget {
  const HostInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AirbnbConstants.paddingL),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Private room in home hosted by Craig',
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: AirbnbConstants.paddingS),
                Text(
                  '2 guests · 1 bedroom · 1 bed · 1 private bath',
                  style: textTheme.labelMedium,
                ),
              ],
            ),
          ),
          const SizedBox(width: AirbnbConstants.paddingM),
          // Host avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AirbnbConstants.radiusXL),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Icon(Icons.person, size: 32),
          ),
        ],
      ),
    );
  }
}
