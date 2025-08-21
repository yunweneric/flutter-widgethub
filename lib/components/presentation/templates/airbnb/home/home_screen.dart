import 'package:flutter/material.dart';
import '../shared/shared.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AirbnbTheme.light,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Search Bar
              AirbnbSearchBar(
                onTap: () {
                  // Handle search tap
                },
                onFilterTap: () {
                  // Handle filter tap
                },
              ),

              // Category Filters
              const CategoryFilter(),

              // Property Card
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PropertyCard(
                        imageUrl: 'https://picsum.photos/400/250?random=1',
                        location: 'Abiansemal, Indonesia',
                        distance: '1,669 kilometers',
                        dates: 'Jul 2 - 7',
                        price: '\$360 night',
                        rating: 4.87,
                        reviewCount: 71,
                        isFavorite: isFavorite,
                        onTap: () {
                          // Handle property tap
                        },
                        onFavoriteTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                      PropertyCard(
                        imageUrl: 'https://picsum.photos/400/250?random=1',
                        location: 'Abiansemal, Indonesia',
                        distance: '1,669 kilometers',
                        dates: 'Jul 2 - 7',
                        price: '\$360 night',
                        rating: 4.87,
                        reviewCount: 71,
                        isFavorite: isFavorite,
                        onTap: () {
                          // Handle property tap
                        },
                        onFavoriteTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
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
