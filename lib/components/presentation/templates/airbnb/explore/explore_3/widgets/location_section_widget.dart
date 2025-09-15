import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class LocationSectionWidget extends StatelessWidget {
  const LocationSectionWidget({super.key});

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
            'Where you\'ll be',
            style: textTheme.displaySmall,
          ),
          const SizedBox(height: AirbnbConstants.paddingM),
          // Map placeholder
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: AirbnbTheme.backgroundGray,
              borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 32),
                  const SizedBox(height: AirbnbConstants.paddingS),
                  Text('Map View', style: textTheme.labelMedium),
                ],
              ),
            ),
          ),
          const SizedBox(height: AirbnbConstants.paddingM),
          Text(
            'Exact location provided after booking.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: AirbnbConstants.paddingS),
          Text(
            'Yonkers, New York, United States',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: AirbnbConstants.paddingS),
          Text(
            'Located on a quiet suburban street.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: AirbnbConstants.paddingS),
          Text(
            'Show more >',
            style: textTheme.bodyMedium?.copyWith(
              color: AirbnbTheme.primaryRed,
            ),
          ),
        ],
      ),
    );
  }
}
