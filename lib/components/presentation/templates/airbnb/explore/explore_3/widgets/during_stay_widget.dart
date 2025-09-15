import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class DuringStayWidget extends StatelessWidget {
  const DuringStayWidget({super.key});

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
            'During your stay',
            style: textTheme.displaySmall,
          ),
          const SizedBox(height: AirbnbConstants.paddingM),
          Text(
            'I will be available on site. When I\'m not on site you can reach me via text, phone or through Airbnb.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: AirbnbConstants.paddingM),
          _buildInfoRow('Language', 'English'),
          _buildInfoRow('Response rate', '100%'),
          _buildInfoRow('Response time', 'within an hour'),
          const SizedBox(height: AirbnbConstants.paddingM),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Handle contact host
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AirbnbConstants.radiusS),
                ),
              ),
              child: Text(
                'Contact Host',
                style: textTheme.labelMedium,
              ),
            ),
          ),
          const SizedBox(height: AirbnbConstants.paddingM),
          Container(
            padding: const EdgeInsets.all(AirbnbConstants.paddingM),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AirbnbConstants.radiusS),
            ),
            child: Text(
              'To protect your payment, never transfer money or communicate outside of the Airbnb website or app.',
              style: textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.only(bottom: AirbnbConstants.paddingS),
        child: Row(
          children: [
            Text(
              '$label: ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
