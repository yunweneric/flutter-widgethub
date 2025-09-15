import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class RoomDetailsWidget extends StatelessWidget {
  const RoomDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AirbnbConstants.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AirbnbConstants.paddingXL),
          Text(
            'Room details',
            style: textTheme.displayMedium,
          ),
          const SizedBox(height: AirbnbConstants.paddingM),
          Row(
            children: [
              Icon(Icons.people, size: 20),
              const SizedBox(width: AirbnbConstants.paddingM),
              Text(
                '2 guests maximum',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AirbnbConstants.paddingS),
          Row(
            children: [
              Icon(Icons.bedroom_parent, size: 20),
              const SizedBox(width: AirbnbConstants.paddingM),
              Text(
                '1 bedroom',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AirbnbConstants.paddingS),
          Row(
            children: [
              Icon(Icons.bed, size: 20),
              const SizedBox(width: AirbnbConstants.paddingM),
              Text(
                '1 bed',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AirbnbConstants.paddingS),
          Row(
            children: [
              Icon(Icons.bathroom, size: 20),
              const SizedBox(width: AirbnbConstants.paddingM),
              Text(
                '1 private bathroom',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
