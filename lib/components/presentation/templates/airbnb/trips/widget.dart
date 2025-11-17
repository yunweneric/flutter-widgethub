import 'package:flutter/material.dart';
import '../shared/shared.dart';

/// Airbnb trips screen displaying user's booked trips and reservations.
///
/// API Reference:
/// - No public properties
///
/// Usage:
/// ```dart
/// TripsScreen()
/// ```
class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Theme(
      data: isDark ? AirbnbTheme.dark : AirbnbTheme.light,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Header
              _TripsHeader(),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AirbnbConstants.paddingL,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AirbnbConstants.height30),

                      // Upcoming Reservations Section
                      _UpcomingReservationsSection(),

                      const SizedBox(height: AirbnbConstants.height40),

                      // Explore Things to Do Section
                      _ExploreThingsToDoSection(),

                      const SizedBox(height: AirbnbConstants.height40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TripsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AirbnbConstants.paddingL,
        vertical: AirbnbConstants.paddingM,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Trips',
              style: textTheme.displayLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class _UpcomingReservationsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming reservations',
          style: textTheme.displaySmall,
        ),
        const SizedBox(height: AirbnbConstants.height20),

        // Reservation Card
        _ReservationCard(),
      ],
    );
  }
}

class _ReservationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).cardColor : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
        boxShadow: [
          BoxShadow(
            color: AirbnbTheme.black.withOpacity(0.1),
            blurRadius: AirbnbConstants.elevationM,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AirbnbConstants.radiusM),
                  topRight: Radius.circular(AirbnbConstants.radiusM),
                ),
                child: Image.network(
                  'https://picsum.photos/400/250',
                  height: AirbnbConstants.height250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: AirbnbConstants.height250,
                      width: double.infinity,
                      color: AirbnbTheme.backgroundGray,
                      child: Icon(
                        Icons.image,
                        size: 60,
                        color: AirbnbTheme.mediumGray,
                      ),
                    );
                  },
                ),
              ),

              // Pending Tag
              Positioned(
                top: AirbnbConstants.paddingM,
                left: AirbnbConstants.paddingM,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AirbnbConstants.paddingM,
                    vertical: AirbnbConstants.paddingXS,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(AirbnbConstants.radiusS),
                  ),
                  child: Text(
                    'Pending',
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Details Section
          Padding(
            padding: const EdgeInsets.all(AirbnbConstants.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location and Host
                Text(
                  'Yonkers',
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: AirbnbConstants.paddingXS),
                Text(
                  'Private room in home hosted by Craig',
                  style: textTheme.bodyMedium,
                ),

                const SizedBox(height: AirbnbConstants.height20),

                // Divider
                Container(
                  height: 1,
                  color: AirbnbTheme.lightGray,
                ),

                const SizedBox(height: AirbnbConstants.height20),

                // Date and Location Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Date
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Feb 13 - 14 2023',
                            style: textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 50,
                      color: AirbnbTheme.lightGray,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                    ),

                    // Location
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Yonkers, New York', style: textTheme.displaySmall),
                          Text(
                            'United States',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreThingsToDoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explore things to do near Yonkers',
          style: textTheme.displaySmall,
        ),
        const SizedBox(height: AirbnbConstants.height20),

        // Experiences List
        SizedBox(
          height: AirbnbConstants.height100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _ExperienceCard(
                imageUrl: 'https://picsum.photos/100/100?random=pottery',
                title: 'Just for you',
                subtitle: '18 experiences',
                imageDescription: 'Pottery making on wheel',
              ),
              const SizedBox(width: AirbnbConstants.paddingM),
              _ExperienceCard(
                imageUrl: 'https://picsum.photos/100/100?random=food',
                title: 'Food',
                subtitle: '23 experiences',
                imageDescription: 'Grilled dishes and kebabs',
              ),
              const SizedBox(width: AirbnbConstants.paddingM),
              _ExperienceCard(
                imageUrl: 'https://picsum.photos/100/100?random=outdoor',
                title: 'Outdoor',
                subtitle: '12 experiences',
                imageDescription: 'Outdoor activities',
              ),
              const SizedBox(width: AirbnbConstants.paddingM),
              _ExperienceCard(
                imageUrl: 'https://picsum.photos/100/100?random=cultural',
                title: 'Cultural',
                subtitle: '8 experiences',
                imageDescription: 'Cultural experiences',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String imageDescription;

  const _ExperienceCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.imageDescription,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: AirbnbConstants.width200,
      child: Row(
        children: [
          // Image on the left
          ClipRRect(
            borderRadius: BorderRadius.circular(AirbnbConstants.radiusS),
            child: Image.network(
              imageUrl,
              width: AirbnbConstants.height80,
              height: AirbnbConstants.height80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: AirbnbConstants.height80,
                  height: AirbnbConstants.height80,
                  color: AirbnbTheme.backgroundGray,
                  child: Icon(
                    Icons.image,
                    size: 30,
                    color: AirbnbTheme.mediumGray,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: AirbnbConstants.paddingM),

          // Text content on the right
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
