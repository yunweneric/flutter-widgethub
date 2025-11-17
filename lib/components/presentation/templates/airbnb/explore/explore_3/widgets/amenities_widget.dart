import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class AmenitiesWidget extends StatelessWidget {
  const AmenitiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AirbnbConstants.paddingL),
      padding: const EdgeInsets.all(AirbnbConstants.paddingM),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What this place offers',
            style: textTheme.displaySmall,
          ),
          const SizedBox(height: AirbnbConstants.paddingM),
          _AmenityItem(icon: Icons.landscape, text: 'River view'),
          _AmenityItem(icon: Icons.kitchen, text: 'Kitchen'),
          _AmenityItem(icon: Icons.wifi, text: 'Wifi'),
          _AmenityItem(icon: Icons.local_parking, text: 'Free parking on premises'),
          _AmenityItem(icon: Icons.ac_unit, text: 'AC - split type ductless system'),
          const SizedBox(height: AirbnbConstants.paddingM),
          Center(
            child: Text(
              'Show all 52 amenities',
              style: textTheme.bodyMedium?.copyWith(
                color: AirbnbTheme.primaryRed,
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class _AmenityItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _AmenityItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AirbnbConstants.paddingM),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: AirbnbConstants.paddingM),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
