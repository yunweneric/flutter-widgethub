import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AirbnbConstants.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, size: 16),
              const SizedBox(width: AirbnbConstants.paddingXS),
              Text(
                '5.0 · 3 reviews',
                style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: AirbnbConstants.paddingM),
          // Review card
          Container(
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
                      'Blair',
                      style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Text('2 weeks ago', style: textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: AirbnbConstants.paddingS),
                Text(
                  'Great location! Cozy, clean, and a welcoming host. Highly recommended!',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: AirbnbConstants.paddingM),
          Center(
            child: Text(
              'Show all 3 reviews',
              style: textTheme.bodyMedium?.copyWith(color: AirbnbTheme.primaryRed),
            ),
          ),
        ],
      ),
    );
  }
}
