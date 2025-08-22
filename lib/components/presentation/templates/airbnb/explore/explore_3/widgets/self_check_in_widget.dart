import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class SelfCheckInWidget extends StatelessWidget {
  const SelfCheckInWidget({super.key});

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
      child: Row(
        children: [
          Icon(Icons.key, size: 20),
          const SizedBox(width: AirbnbConstants.paddingM),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Self check-in',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Check yourself in with the keypad',
                style: textTheme.bodySmall,
              ),
            ],
          )
        ],
      ),
    );
  }
}
