import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AirbnbConstants.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Private bedroom and bathroom in a quiet suburban home. Minutes away from bus/train station. 45 minutes to Manhattan. Near Cross County Mall and restaurants. Free parking and fast WiFi.',
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
