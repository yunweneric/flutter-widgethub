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
          _buildAmenityItem(Icons.landscape, 'River view'),
          _buildAmenityItem(Icons.kitchen, 'Kitchen'),
          _buildAmenityItem(Icons.wifi, 'Wifi'),
          _buildAmenityItem(Icons.local_parking, 'Free parking on premises'),
          _buildAmenityItem(Icons.ac_unit, 'AC - split type ductless system'),
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

  Widget _buildAmenityItem(IconData icon, String text) {
    return Builder(
      builder: (context) => Padding(
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
      ),
    );
  }
}
