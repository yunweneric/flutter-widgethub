import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back button
        GestureDetector(
          onTap: () {
            // Handle back navigation
          },
          child: Container(
            padding: const EdgeInsets.all(AirbnbConstants.paddingS),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: AirbnbConstants.elevationM,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Icon(Icons.arrow_back, size: 20),
          ),
        ),

        const Spacer(),

        // Share button
        GestureDetector(
          onTap: () {
            // Handle share
          },
          child: Container(
            padding: const EdgeInsets.all(AirbnbConstants.paddingS),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: AirbnbConstants.elevationM,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Icon(Icons.favorite, size: 20),
          ),
        ),

        const SizedBox(width: AirbnbConstants.paddingM),

        // Menu button
        GestureDetector(
          onTap: () {
            // Handle menu
          },
          child: Container(
            padding: const EdgeInsets.all(AirbnbConstants.paddingS),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: AirbnbConstants.elevationM,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Icon(Icons.more_horiz, size: 20),
          ),
        ),
      ],
    );
  }
}
