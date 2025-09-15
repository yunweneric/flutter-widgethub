const explore1Code = """import 'package:flutter/material.dart';
import '../../shared/shared.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFavorite = false;
  bool isFavorite2 = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Theme(
      data: isDark ? AirbnbTheme.dark : AirbnbTheme.light,
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

              // Property Cards
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // First Property Card
                      PropertyCard(
                        imageUrl:
                            'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
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

                      // Second Property Card
                      PropertyCard(
                        imageUrl:
                            'https://images.unsplash.com/photo-1571896349842-33c89424de2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2068&q=80',
                        location: 'Bali, Indonesia',
                        distance: '1,672 kilometers',
                        dates: 'Jul 5 - 10',
                        price: '\$420 night',
                        rating: 4.92,
                        reviewCount: 128,
                        isFavorite: isFavorite2,
                        onTap: () {
                          // Handle property tap
                        },
                        onFavoriteTap: () {
                          setState(() {
                            isFavorite2 = !isFavorite2;
                          });
                        },
                      ),

                      // Third Property Card
                      PropertyCard(
                        imageUrl:
                            'https://images.unsplash.com/photo-1523217582562-09d0def993a6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2080&q=80',
                        location: 'Ubud, Indonesia',
                        distance: '1,675 kilometers',
                        dates: 'Jul 8 - 13',
                        price: '\$380 night',
                        rating: 4.78,
                        reviewCount: 95,
                        isFavorite: false,
                        onTap: () {
                          // Handle property tap
                        },
                        onFavoriteTap: () {
                          // Handle favorite tap
                        },
                      ),

                      // Fourth Property Card
                      PropertyCard(
                        imageUrl:
                            'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2073&q=80',
                        location: 'Seminyak, Indonesia',
                        distance: '1,678 kilometers',
                        dates: 'Jul 10 - 15',
                        price: '\$450 night',
                        rating: 4.85,
                        reviewCount: 156,
                        isFavorite: false,
                        onTap: () {
                          // Handle property tap
                        },
                        onFavoriteTap: () {
                          // Handle favorite tap
                        },
                      ),

                      // Fifth Property Card
                      PropertyCard(
                        imageUrl:
                            'https://images.unsplash.com/photo-1582268611958-ebfd161ef9cf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
                        location: 'Canggu, Indonesia',
                        distance: '1,680 kilometers',
                        dates: 'Jul 12 - 17',
                        price: '\$395 night',
                        rating: 4.91,
                        reviewCount: 203,
                        isFavorite: false,
                        onTap: () {
                          // Handle property tap
                        },
                        onFavoriteTap: () {
                          // Handle favorite tap
                        },
                      ),

                      // Map Button
                      MapButton(
                        onTap: () {
                          // Handle map tap
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
""";
