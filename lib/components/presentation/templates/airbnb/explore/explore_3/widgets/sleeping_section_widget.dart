import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class SleepingSectionWidget extends StatelessWidget {
  const SleepingSectionWidget({super.key});

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
          Text(
            'Where you\'ll sleep',
            style: textTheme.displaySmall,
          ),
          const SizedBox(height: AirbnbConstants.paddingM),
          Row(
            children: [
              Icon(Icons.bed, size: 24),
              const SizedBox(width: AirbnbConstants.paddingM),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bedroom',
                    style: textTheme.bodyLarge,
                  ),
                  Text(
                    '1 queen bed',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AirbnbTheme.mediumGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
