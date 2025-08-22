import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class PropertyTitleWidget extends StatelessWidget {
  const PropertyTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AirbnbConstants.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Private room in Yonkers close to bus/train station',
            style: textTheme.displayMedium,
          ),
          const SizedBox(height: AirbnbConstants.paddingS),
          Row(
            children: [
              Icon(Icons.star, size: 16),
              const SizedBox(width: AirbnbConstants.paddingXS),
              Text(
                '5.0 · 3 reviews',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AirbnbConstants.paddingS),
          Text(
            'Yonkers, New York, United States',
            style: textTheme.bodyMedium?.copyWith(
              color: AirbnbTheme.mediumGray,
            ),
          ),
        ],
      ),
    );
  }
}
