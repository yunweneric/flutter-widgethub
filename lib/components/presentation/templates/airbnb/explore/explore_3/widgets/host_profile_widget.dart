import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class HostProfileWidget extends StatelessWidget {
  const HostProfileWidget({super.key});

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hosted by Craig',
                      style: textTheme.displaySmall,
                    ),
                    const SizedBox(height: AirbnbConstants.paddingS),
                    Text(
                      'Joined in July 2014',
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AirbnbConstants.radiusXL),
                  color: Theme.of(context).cardColor,
                ),
                child: Icon(
                  Icons.person,
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: AirbnbConstants.paddingM),
          Row(
            children: [
              Icon(
                Icons.star,
                size: 16,
              ),
              const SizedBox(width: AirbnbConstants.paddingXS),
              Text(
                '3 Reviews',
                style: textTheme.bodyMedium,
              ),
              const SizedBox(width: AirbnbConstants.paddingM),
              Icon(Icons.verified, size: 16),
              const SizedBox(width: AirbnbConstants.paddingXS),
              Text(
                'Identity verified',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AirbnbConstants.paddingM),
          Text(
            'Military: US Air Force Reserves\nCivilian: Director of Distribution Operations at a NY hospital... Read more',
            style: textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
