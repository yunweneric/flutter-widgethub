import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class AdditionalSectionsWidget extends StatelessWidget {
  const AdditionalSectionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AirbnbConstants.paddingL),
      child: Column(
        children: [
          const SizedBox(height: AirbnbConstants.paddingXL),
          _CollapsibleSection(title: 'Availability', subtitle: 'Feb 13 - 14'),
          _CollapsibleSection(title: 'House rules', subtitle: 'Check-in: After 1:00 PM'),
          _CollapsibleSection(
              title: 'Health & safety',
              subtitle: 'Airbnb\'s COVID-19 safety practices apply\nSecurity camera/recording device'),
          _CollapsibleSection(title: 'Cancellation policy', subtitle: 'Free cancellation before Feb 12'),
        ],
      ),
    );
  }

}

class _CollapsibleSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const _CollapsibleSection({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AirbnbConstants.paddingM),
      padding: const EdgeInsets.all(AirbnbConstants.paddingM),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: AirbnbConstants.paddingS),
                Text(subtitle),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}
