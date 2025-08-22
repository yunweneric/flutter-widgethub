import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class AirCoverWidget extends StatelessWidget {
  const AirCoverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(AirbnbConstants.paddingL),
      padding: const EdgeInsets.all(AirbnbConstants.paddingM),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Aircover',
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                'Learn more',
                style: textTheme.bodyMedium?.copyWith(
                  color: AirbnbTheme.primaryRed,
                ),
              ),
            ],
          ),
          const SizedBox(height: AirbnbConstants.paddingS),
          Text(
            'Every booking includes free protection from Host cancellations, listing inaccuracies, and other issues like trouble checking in.',
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
