import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class BookingSectionWidget extends StatelessWidget {
  const BookingSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AirbnbConstants.paddingL),
      padding: const EdgeInsets.all(AirbnbConstants.paddingM),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$32',
                      style: textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'night',
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle reserve
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AirbnbTheme.primaryRed,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AirbnbConstants.radiusS),
                  ),
                ),
                child: Text(
                  'Reserve',
                  style: textTheme.labelLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: AirbnbConstants.paddingM),
          Row(
            children: [
              Text(
                'Feb 13 - 14',
                style: textTheme.bodyMedium,
              ),
              const Spacer(),
              Text(
                'Free cancellation before Feb 12',
                style: textTheme.bodySmall?.copyWith(
                  color: AirbnbTheme.mediumGray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
