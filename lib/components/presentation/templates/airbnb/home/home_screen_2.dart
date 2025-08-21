import 'package:flutter/material.dart';
import '../shared/shared.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AirbnbTheme.light,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Search Bar with Manhattan search
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AirbnbConstants.paddingL,
                  vertical: AirbnbConstants.paddingM,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // Handle search tap
                    },
                    borderRadius: BorderRadius.circular(AirbnbConstants.radiusXXL),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AirbnbConstants.paddingL,
                        vertical: AirbnbConstants.paddingM,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AirbnbConstants.radiusXXL),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            AirbnbConstants.searchIcon,
                            color: Colors.grey[600],
                            size: 20,
                          ),
                          const SizedBox(width: AirbnbConstants.paddingM),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Manhattan',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  'Feb 13 - 14, 2023 (±1) • 1 guest',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AirbnbConstants.paddingM),
                          GestureDetector(
                            onTap: () {
                              // Handle filter tap
                            },
                            child: Container(
                              padding: const EdgeInsets.all(AirbnbConstants.paddingS),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400]!),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                AirbnbConstants.filterIcon,
                                color: Colors.grey[600],
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Property Cards
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Private Room in Yonkers Property Card
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                          horizontal: AirbnbConstants.paddingL,
                          vertical: AirbnbConstants.paddingS,
                        ),
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
                                    color: Colors.grey[200],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[200],
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.bedroom_parent,
                                                size: 48,
                                                color: Colors.grey[600],
                                              ),
                                              const SizedBox(height: AirbnbConstants.paddingS),
                                              Text(
                                                'Private Room',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      color: Colors.grey[600],
                                                    ),
                                              ),
                                            ],
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
                                    onTap: () {
                                      setState(() {
                                        isFavorite = !isFavorite;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(AirbnbConstants.paddingS),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(AirbnbConstants.radiusM),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        isFavorite
                                            ? AirbnbConstants.heartFilledIcon
                                            : AirbnbConstants.heartIcon,
                                        color: isFavorite ? Colors.red : Colors.black,
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
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                      const SizedBox(width: AirbnbConstants.paddingXS),
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                      const SizedBox(width: AirbnbConstants.paddingXS),
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                      const SizedBox(width: AirbnbConstants.paddingXS),
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                      const SizedBox(width: AirbnbConstants.paddingXS),
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AirbnbConstants.paddingM),

                            // Property details
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: AirbnbConstants.paddingS),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title and rating row
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Private room in Yonkers',
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            AirbnbConstants.starIcon,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                          const SizedBox(width: AirbnbConstants.paddingXS),
                                          Text(
                                            '5.0 (3)',
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AirbnbConstants.paddingXS),

                                  // Description
                                  Text(
                                    'Private room in Yonkers close to bus...',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: AirbnbConstants.paddingXS),

                                  // Bed type
                                  Text(
                                    '1 Queen Bed',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: AirbnbConstants.paddingXS),

                                  // Dates
                                  Text(
                                    'Feb 13 - 14',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: AirbnbConstants.paddingXS),

                                  // Price
                                  Row(
                                    children: [
                                      Text(
                                        '\$38 night',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Colors.grey[600],
                                            ),
                                      ),
                                      const SizedBox(width: AirbnbConstants.paddingS),
                                      Text(
                                        '\$48 total',
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              decoration: TextDecoration.underline,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Second Property Card (partially visible)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                          horizontal: AirbnbConstants.paddingL,
                          vertical: AirbnbConstants.paddingS,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
                                color: Colors.grey[200],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Map Button overlaid on the image
                            Positioned(
                              bottom: AirbnbConstants.paddingM,
                              right: AirbnbConstants.paddingM,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle map tap
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AirbnbConstants.paddingM,
                                    horizontal: AirbnbConstants.paddingL,
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      AirbnbConstants.mapIcon,
                                      size: 20,
                                    ),
                                    const SizedBox(width: AirbnbConstants.paddingS),
                                    Text(
                                      'Map',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Add some bottom padding
                      const SizedBox(height: AirbnbConstants.paddingXL),
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
