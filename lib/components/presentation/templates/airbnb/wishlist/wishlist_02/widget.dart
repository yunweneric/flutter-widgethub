import 'package:flutter/material.dart';
import '../../shared/shared.dart';

/// Airbnb wishlist screen variant 2 with different layout for saved properties.
///
/// API Reference:
/// - No public properties
///
/// Usage:
/// ```dart
/// Wishlist02()
/// ```
class Wishlist02 extends StatelessWidget {
  const Wishlist02({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Theme(
      data: isDark ? AirbnbTheme.dark : AirbnbTheme.light,
      child: Scaffold(
        appBar: const WishlistAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AirbnbConstants.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AirbnbConstants.height10),
                Text(
                  'Nice',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: AirbnbConstants.height20),
                // Filter/Selection Bar
                const WishlistFilterBar(),
                const SizedBox(height: AirbnbConstants.height20),

                // Main Content
                Expanded(
                  child: ListView(
                    children: [
                      // Main Listing Card
                      PropertyCard(
                        imageUrl: 'https://picsum.photos/seed/modern-house/400/300',
                        location: 'Putnam Valley, New York',
                        distance: '2 hours away',
                        dates: 'May 14 - 19',
                        price: '\$1,700 night',
                        rating: 4.98,
                        reviewCount: 61,
                        isFavorite: true,
                        onTap: () {
                          // Handle property tap
                        },
                        onFavoriteTap: () {
                          // Handle favorite tap
                        },
                      ),

                      const SizedBox(height: AirbnbConstants.height30),

                      // Second Listing Card (with map button)
                      const WishlistSecondCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WishlistAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WishlistAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Icon(Icons.arrow_back, size: 20),
      actions: [
        // Share button
        GestureDetector(
          onTap: () {
            // Handle share
          },
          child: Icon(Icons.share, size: 20),
        ),
        const SizedBox(width: AirbnbConstants.height10),

        // More options button
        GestureDetector(
          onTap: () {
            // Handle more options
          },
          child: Icon(Icons.more_vert, size: 20),
        ),
        const SizedBox(width: AirbnbConstants.height10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class WishlistFilterBar extends StatelessWidget {
  const WishlistFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        // Date filter button
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AirbnbConstants.paddingM,
            vertical: AirbnbConstants.paddingS,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColorDark),
            borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
          ),
          child: Text('May 14 - 19', style: textTheme.labelMedium),
        ),

        const SizedBox(width: AirbnbConstants.paddingM),

        // Guests filter button
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AirbnbConstants.paddingM,
            vertical: AirbnbConstants.paddingS,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColorDark),
            borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
          ),
          child: Text('Guests', style: textTheme.labelMedium),
        ),
      ],
    );
  }
}

class WishlistSecondCard extends StatelessWidget {
  const WishlistSecondCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AirbnbConstants.paddingL),
      child: Stack(
        children: [
          // Main image
          ClipRRect(
            borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
            child: Image.network(
              'https://picsum.photos/seed/second-house/400/300',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
                  ),
                  child: Icon(Icons.home, size: 48),
                );
              },
            ),
          ),

          // Superhost badge
          Positioned(
            top: AirbnbConstants.paddingM,
            left: AirbnbConstants.paddingM,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AirbnbConstants.paddingM,
                vertical: AirbnbConstants.paddingS,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
              ),
              child: Text(
                'SUPERHOST',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),

          // Heart button
          Positioned(
            top: AirbnbConstants.paddingM,
            right: AirbnbConstants.paddingM,
            child: GestureDetector(
              onTap: () {
                // Handle favorite
              },
              child: Container(
                padding: const EdgeInsets.all(AirbnbConstants.paddingS),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: AirbnbConstants.elevationM,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.favorite,
                  color: AirbnbTheme.primaryRed,
                  size: 20,
                ),
              ),
            ),
          ),

          // Map button (reuse existing MapButton component)
          Positioned(
            bottom: AirbnbConstants.paddingM,
            right: AirbnbConstants.paddingM,
            child: MapButton(
              onTap: () {
                // Handle map view
              },
            ),
          ),
        ],
      ),
    );
  }
}
