import 'package:flutter/material.dart';
import '../constants.dart';

/// A property card component displaying property information with image, rating, and pricing.
///
/// API Reference:
/// - [imageUrl]: URL of the property image
/// - [location]: Property location text
/// - [distance]: Distance from location text
/// - [dates]: Available dates text
/// - [price]: Price per night text
/// - [rating]: Property rating (0.0 to 5.0)
/// - [reviewCount]: Number of reviews
/// - [isFavorite]: Whether the property is favorited
/// - [onTap]: Callback when card is tapped
/// - [onFavoriteTap]: Callback when favorite button is tapped
///
/// Usage:
/// ```dart
/// PropertyCard(
///   imageUrl: 'https://example.com/image.jpg',
///   location: 'New York',
///   distance: '2 hours away',
///   dates: 'May 14 - 19',
///   price: '\$200 night',
///   rating: 4.8,
///   reviewCount: 45,
///   isFavorite: true,
///   onTap: () {},
///   onFavoriteTap: () {},
/// )
/// ```
class PropertyCard extends StatelessWidget {
  final String imageUrl;
  final String location;
  final String distance;
  final String dates;
  final String price;
  final double rating;
  final int reviewCount;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const PropertyCard({
    super.key,
    required this.imageUrl,
    required this.location,
    required this.distance,
    required this.dates,
    required this.price,
    required this.rating,
    required this.reviewCount,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
                    color: colorScheme.surfaceVariant,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: colorScheme.surfaceVariant,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                size: 48,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: AirbnbConstants.paddingS),
                              Text(
                                'Property Image',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: colorScheme.surfaceVariant,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              color: colorScheme.primary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Favorite button
                Positioned(
                  top: AirbnbConstants.paddingM,
                  right: AirbnbConstants.paddingM,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      padding: const EdgeInsets.all(AirbnbConstants.paddingS),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Icon(
                        isFavorite ? AirbnbConstants.heartFilledIcon : AirbnbConstants.heartIcon,
                        color: isFavorite ? colorScheme.primary : colorScheme.onSurface,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                // Image counter dots
                Positioned(
                  left: 0,
                  bottom: 30,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Dot(isActive: true, colorScheme: colorScheme),
                      const SizedBox(width: AirbnbConstants.paddingXS),
                      _Dot(isActive: false, colorScheme: colorScheme),
                      const SizedBox(width: AirbnbConstants.paddingXS),
                      _Dot(isActive: false, colorScheme: colorScheme),
                      const SizedBox(width: AirbnbConstants.paddingXS),
                      _Dot(isActive: false, colorScheme: colorScheme),
                      const SizedBox(width: AirbnbConstants.paddingXS),
                      _Dot(isActive: false, colorScheme: colorScheme),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AirbnbConstants.paddingM),

            // Property details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AirbnbConstants.paddingS),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location and rating row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          location,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            AirbnbConstants.starIcon,
                            color: colorScheme.onSurface,
                            size: 16,
                          ),
                          const SizedBox(width: AirbnbConstants.paddingXS),
                          Text(
                            '$rating ($reviewCount)',
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AirbnbConstants.paddingXS),

                  // Distance
                  Text(
                    distance,
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(height: AirbnbConstants.paddingXS),

                  // Dates
                  Text(
                    dates,
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(height: AirbnbConstants.paddingXS),

                  // Price
                  Text(
                    price,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _Dot extends StatelessWidget {
  final bool isActive;
  final ColorScheme colorScheme;

  const _Dot({
    required this.isActive,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? colorScheme.surface : colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
